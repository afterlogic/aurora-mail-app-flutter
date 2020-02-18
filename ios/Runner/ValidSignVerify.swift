//
//  SignVerify.swift
//  PrivateMail
//
//  Created by Alexander Orlov on 15.01.2020.
//  Copyright © 2020 PrivateRouter. All rights reserved.
//
import Foundation
import BouncyCastle_ObjC
import DMSOpenPGP

public class ValidDMSPGPClearTextVerifier {

    public let cleartext: String
    public let signature: String

    public let hashHeaders: [String]
    public let message: String
    public let signatureList: BCOpenpgpPGPSignatureList?

    public init(cleartext: String) throws {
        self.cleartext = cleartext

        let scanner = Scanner(string: cleartext)
        scanner.charactersToBeSkipped = nil

        // Jump to cleartext signature begin
        scanner.scanUpTo("-----BEGIN PGP SIGNED MESSAGE-----", into: nil)

        // Read -----BEGIN PGP SIGNED MESSAGE-----\r\n
        var signedMessageHeader: NSString?
        scanner.scanUpToCharacters(from: .newlines, into: &signedMessageHeader)
        scanner.scanCharacters(from: .newlines, into: nil)
        guard signedMessageHeader == "-----BEGIN PGP SIGNED MESSAGE-----" else {
            throw DMSPGPError.invalidCleartext
        }

        // Read armor headers
        var hashHeaders: [String] = []
        var nextLine: NSString? = ""
        var lastScanLocation: Int

        repeat {
            lastScanLocation = scanner.scanLocation
            scanner.scanUpToCharacters(from: .newlines, into: &nextLine)
            scanner.scanString("\r", into: nil)
            scanner.scanString("\n", into: nil)
            guard let hashHeader = nextLine else {
                throw DMSPGPError.invalidCleartext
            }
            nextLine = nil
            hashHeaders.append(hashHeader as String)

            if !scanner.scanUpToCharacters(from: .newlines, into: &nextLine) {
                // got one empty line
                // no more hash header
                break
            }

            if lastScanLocation == scanner.scanLocation {
                // scanner not move
                throw DMSPGPError.invalidCleartext
            }
        } while lastScanLocation != scanner.scanLocation
        self.hashHeaders = hashHeaders

        // Read one empty line
        scanner.scanString("\r", into: nil)
        scanner.scanString("\n", into: nil)

        // Read cleartext
        var rawMessage: NSString?
        scanner.scanUpTo("-----BEGIN PGP SIGNATURE-----", into: &rawMessage)
        let message = rawMessage as String?     // Message could be empty
        
        let end = message!.index(message!.startIndex, offsetBy: message!.count-2)
        self.message = String(message![...end])
           
        // Read footer
        var footer: NSString?
        scanner.scanUpTo("-----END PGP SIGNATURE-----", into: &footer)

        guard var signature = (footer as String?), !signature.isEmpty else {
            throw DMSPGPError.invalidCleartext
        }
        signature.append(contentsOf: "-----END PGP SIGNATURE-----")
        self.signature = signature

        self.signatureList = try! DMSPGPClearTextVerifier.signatureList(from: signature)
    }

}
extension ValidDMSPGPClearTextVerifier {

    public var signatureVerifier: DMSPGPSignatureVerifier {
        return DMSPGPSignatureVerifier(message: message, onePassSignatureList: nil, signatureList: signatureList)
    }

}

extension DMSPGPSignatureVerifier {

    public func verifySignature(message:String, use publicKeyRing: BCOpenpgpPGPPublicKeyRing) -> VerifyResult {
        guard let signatureList = signatureList, !signatureList.isEmpty(),
        !signatureListKeyInfos.isEmpty else {
            return .noSignature
        }

        guard let signatureKey = publicKeyRing.primarySignatureKey else {
            return VerifyResult.unknownSigner(signatureListKeyInfos)
        }

        guard let iterator = signatureList.iterator() else {
            return .noSignature
        }

        while iterator.hasNext() {
            guard let signature = iterator.next() as? BCOpenpgpPGPSignature,
            signatureKey.keyID == signature.keyID else {
                continue
            }

            let builderProvider = BCOpenpgpOperatorJcajceJcaPGPContentVerifierBuilderProvider()
                .setProviderWith(BCJceProviderBouncyCastleProvider.PROVIDER_NAME)
            signature.init__(with: builderProvider, with: signatureKey)
            signature.update(with: IOSByteArray(nsData: Data(message.utf8)))
            if signature.verify() {
                return .valid
            }
        }

        return .invalid
    }

}

public class ValidDMSPGPDecryptor {

    public let armoredMessage: String
    public let encryptingKeyIDs: [String]

    public let encryptedDataDict: [String: BCOpenpgpPGPPublicKeyEncryptedData]
    public let hiddenRecipientsDataList: [BCOpenpgpPGPPublicKeyEncryptedData]

    private(set) public var onePassSignatureList: BCOpenpgpPGPOnePassSignatureList?
    private(set) public var signatureList: BCOpenpgpPGPSignatureList?
    private(set) public var modificationTime: Date?

    public init(armoredMessage message: String) throws {
        self.armoredMessage = message

        let byteArray = IOSByteArray(nsData: Data(message.utf8))!
        let input = JavaIoByteArrayInputStream(byteArray: byteArray)
        guard let armoredInput = BCOpenpgpPGPUtil.getDecoderStream(with: input) as? BCBcpgArmoredInputStream else {
            throw DMSPGPError.notArmoredInput
        }
        defer {
            input.close()
            armoredInput.close()
        }

        // Get encrypted data list
        var encryptedDataList: BCOpenpgpPGPEncryptedDataList?
        do {
            let result = try ExceptionCatcher.catchException {
                let objectFactory = BCOpenpgpPGPObjectFactory(javaIoInputStream: armoredInput, with: BCOpenpgpOperatorJcajceJcaKeyFingerprintCalculator())

                var object = objectFactory.nextObject()
                while object != nil {
                    guard let list = object as? BCOpenpgpPGPEncryptedDataList else {
                        object = objectFactory.nextObject()
                        continue
                    }

                    return list
                }

                return nil
            }

            encryptedDataList = result as? BCOpenpgpPGPEncryptedDataList
        } catch {
            // continue decrypt if got encryptedDataList
        }

        guard let iterator = encryptedDataList?.iterator() else {
            throw DMSPGPError.invalidMessage
        }

        // Get encrypted data
        var keyIDs = Set<String>()
        var encryptedDataDict: [String: BCOpenpgpPGPPublicKeyEncryptedData] = [:]
        var hiddenRecipientsDataList = [BCOpenpgpPGPPublicKeyEncryptedData]()
        while iterator.hasNext() {
            guard let data = iterator.next() as? BCOpenpgpPGPPublicKeyEncryptedData else {
                continue
            }

            let keyID = String(fromPGPKeyID: data.getKeyID())
            if keyID.isHiddenRecipientID {
                hiddenRecipientsDataList.append(data)
            } else {
                keyIDs.insert(keyID)
                encryptedDataDict[keyID] = data
            }
        }

        guard (!keyIDs.isEmpty && !encryptedDataDict.isEmpty) || !hiddenRecipientsDataList.isEmpty else {
            throw DMSPGPError.invalidMessage
        }

        self.encryptingKeyIDs = Array(keyIDs)
        self.encryptedDataDict = encryptedDataDict
        self.hiddenRecipientsDataList = hiddenRecipientsDataList
    }

}

extension ValidDMSPGPDecryptor {

    public func decrypt(secretKey: BCOpenpgpPGPSecretKey, password: String) throws -> String {
        guard let privateKey = secretKey.getEncryptingPrivateKey(password: password) else {
            throw DMSPGPError.invalidSecrectKeyPassword
        }

        return try decrypt(privateKey: privateKey, keyID: secretKey.keyID)
    }
    
    
    public func decrypt(privateKey: BCOpenpgpPGPPrivateKey, keyID: String) throws -> String {
        guard let encryptedData = encryptedDataDict[keyID] else {
            throw DMSPGPError.invalidPrivateKey
        }
        return try decrypt(privateKey: privateKey, encryptedData: encryptedData)
    }
    
    /// Decrypt without known keyID, used to support hidden recipients key IDs
    public func decrypt(privateKey: BCOpenpgpPGPPrivateKey, encryptedData: BCOpenpgpPGPPublicKeyEncryptedData) throws -> String {
        var literalData: BCOpenpgpPGPLiteralData?
        
        var message: String?
        
        let inputStream: JavaIoInputStream? = try! ExceptionCatcher.catchException {
            let object = encryptedData.getDataStream(with: BCOpenpgpOperatorBcBcPublicKeyDataDecryptorFactory(bcOpenpgpPGPPrivateKey: privateKey))
            return object
            } as? JavaIoInputStream
        guard let input = inputStream else {
            throw DMSPGPError.invalidPrivateKey
        }
        defer {
            input.close()
        }
        var factory = BCOpenpgpPGPObjectFactory(javaIoInputStream: input, with: BCOpenpgpOperatorJcajceJcaKeyFingerprintCalculator())
        var object: Any? = try? ExceptionCatcher.catchException {
            return factory.nextObject()
        }
        while object != nil {
            switch object {
            case let data as BCOpenpgpPGPCompressedData:
                guard let dataStream = data.getStream() else {
                    throw DMSPGPError.internal
                }
                factory = SkipMarkerPGPObjectFactory(javaIoInputStream: dataStream, with: BCOpenpgpOperatorJcajceJcaKeyFingerprintCalculator())
            case let list as BCOpenpgpPGPOnePassSignatureList:
                onePassSignatureList = list
            case let list as BCOpenpgpPGPSignatureList:
                signatureList = list
            case let data as BCOpenpgpPGPLiteralData:
                literalData = data
                message = {
                    guard let input = data.getInputStream() else { return nil }
                    let output = JavaIoByteArrayOutputStream()
                    
                    BCUtilIoStreams.pipeAll(with: input, with: output)
                    output.close()
                    input.close()
                    return output.toString(with: "UTF-8")
                }()
            default:
                break
            }
            
            object = try? ExceptionCatcher.catchException {
                return factory.nextObject()
            }
        }
        
        if let modificationTime = literalData?.getModificationTime() {
            self.modificationTime = Date(javaUtilDate: modificationTime)
        }
        
        guard let result = message else {
            throw DMSPGPError.invalidMessage
        }
        
        return result
    }
}
extension ValidDMSPGPDecryptor {

    /// Verify armored message
    ///
    /// - Parameter message: armored message
    /// - Returns: true when valid armored message
    public static func verify(armoredMessage message: String) -> Bool {
        guard let byteArray = IOSByteArray(nsData: Data(message.utf8)) else {
            return false
        }

        let input = JavaIoByteArrayInputStream(byteArray: byteArray)
        let inputStream: BCBcpgArmoredInputStream? = try! ExceptionCatcher.catchException {
            return BCOpenpgpPGPUtil.getDecoderStream(with: input)
        } as? BCBcpgArmoredInputStream

        guard inputStream != nil else {
            return false
        }

        return true
    }
}

fileprivate extension String {
    var isHiddenRecipientID: Bool {
        return replacingOccurrences(of: "0", with: "").isEmpty
    }
}
