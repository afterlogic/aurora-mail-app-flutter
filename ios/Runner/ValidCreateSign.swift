//
//  ValidCreateSign.swift
//  PrivateMail
//
//  Created by Alexander Orlov on 27.01.2020.
//  Copyright © 2020 PrivateRouter. All rights reserved.
//

import Foundation
import BouncyCastle_ObjC
import DMSOpenPGP

extension DMSPGPEncryptor {

    public func encrypt(fullMessage: String) throws -> String {
        let message = fullMessage
        let output = JavaIoByteArrayOutputStream()
        let armoredOutput = TCMessageArmoredOutputStream(javaIoOutputStream: output)

        let messageData = Data(message.utf8)
        let messageBytes = IOSByteArray(nsData: messageData)!

        let signer = self.signer

        switch (encryptedDataGenerator, signer) {
        // encrypt and sign if possiable
        case let (encryptedDataGenerator?, _):
            let encryptDate = JavaUtilDate()
            let encryptedOutput = encryptedDataGenerator.open(with: armoredOutput, with: IOSByteArray(length: 1 << 16))
            let compressedDataGenerator = BCOpenpgpPGPCompressedDataGenerator(int: compressAlgorithm)
            let bcpgOutputStream = encryptedOutput.flatMap { encryptedOutput -> BCBcpgBCPGOutputStream in
                guard compressAlgorithm != BCBcpgCompressionAlgorithmTags.UNCOMPRESSED else {
                    return BCBcpgBCPGOutputStream(javaIoOutputStream: encryptedOutput)
                }
                let compressedOutput = compressedDataGenerator.open(with: encryptedOutput)
                return BCBcpgBCPGOutputStream(javaIoOutputStream: compressedOutput)
            }

            guard let bcpgOutput = bcpgOutputStream else {
                compressedDataGenerator.close()
                encryptedOutput?.close()

                armoredOutput.close()
                output.close()
                throw DMSPGPError.internal
            }

            signer?.signatureGenerator.generateOnePassVersion(withBoolean: false)?.encode(with: bcpgOutput)

            let literalDataGenerator = BCOpenpgpPGPLiteralDataGenerator()
            guard let literalDataOutput = literalDataGenerator
                .open(with: bcpgOutput,
                      withChar: BCOpenpgpPGPLiteralData.UTF8,
                      with: BCOpenpgpPGPLiteralData.CONSOLE,
                      with: encryptDate,
                      with: IOSByteArray(length: 1 << 16)) else {
                literalDataGenerator.close()
                bcpgOutput.close()
                compressedDataGenerator.close()
                encryptedOutput?.close()

                armoredOutput.close()
                output.close()
                throw DMSPGPError.internal
            }

            literalDataOutput.write(with: messageBytes)
            literalDataOutput.write(with: IOSByteArray(nsData: Data("\r\n".utf8)))
            signer?.signatureGenerator.update(with: messageBytes)
            literalDataOutput.close()
            signer?.signatureGenerator.generate()?.encode(with: literalDataOutput)

            bcpgOutput.close()
            compressedDataGenerator.close()
            encryptedOutput?.close()
            encryptedDataGenerator.close()

        // clear sign
        case let (nil, signer?):
            return signer.sign(fullMessage: message)
        default:
            throw DMSPGPError.internal
        }

        armoredOutput.close()
        output.close()

        return output.toString(with: "UTF-8")
    }

}
extension DMSPGPSigner {

    /// Cleartext sign
    ///
    /// - Parameter message: message to sign
    /// - Returns: armored cleartext signature
    public func sign(fullMessage: String) -> String {
        let message = fullMessage
        let output = JavaIoByteArrayOutputStream()
        let armoredOutput = TCMessageArmoredOutputStream(javaIoOutputStream: output)

        let messageData = Data(message.utf8)
        let messageBytes = IOSByteArray(nsData: messageData)!

        armoredOutput.beginClearText(with: BCBcpgHashAlgorithmTags.SHA512)
        armoredOutput.write(with: messageBytes)
        signatureGenerator.update(with: messageBytes)
        armoredOutput.write(with: IOSByteArray(nsData: Data("\r\n".utf8)))
        armoredOutput.endClearText()
        let bcpgOutput = BCBcpgBCPGOutputStream(javaIoOutputStream: armoredOutput)
        signatureGenerator.generate()?.encode(with: bcpgOutput)
        bcpgOutput.close()
        armoredOutput.close()
        output.close()

        return output.toString(with: "UTF-8")
    }
}
