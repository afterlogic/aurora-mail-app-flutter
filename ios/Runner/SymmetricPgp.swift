import Foundation
import BouncyCastle_ObjC
class SymmetricPgp {
    static func encrypt(
        _ input:JavaIoInputStream,
        _ output:JavaIoOutputStream,
        _ tempFile:JavaIoFile,
        _ password:String,
        _ length:jlong )  {
        
        compress(input, JavaIoFileOutputStream(javaIoFile: tempFile),length)
        let preparedInput=JavaIoFileInputStream(javaIoFile: tempFile)

        let aes256 = 9
        let encGen = BCOpenpgpPGPEncryptedDataGenerator(
            bcOpenpgpOperatorPGPDataEncryptorBuilder:
            BCOpenpgpOperatorJcajceJcePGPDataEncryptorBuilder
                .init(int: jint(aes256))
                .setWithIntegrityPacketWithBoolean(true)?
                .setSecureRandomWith(JavaSecuritySecureRandom())?
                .setProviderWith("BC")
        )
        encGen.addMethod(with:
            BCOpenpgpOperatorJcajceJcePBEKeyEncryptionMethodGenerator
                .init(charArray: IOSCharArray.init(nsString:password))
                .setProviderWith("BC")
        )
        let encOut=encGen.open(with: output, withLong: tempFile.length())
        BCUtilIoStreams.pipeAll(with: preparedInput, with: encOut)
        tempFile.delete__()
        encOut?.close()
      
    }
    static  func decrypt(
        _ input:JavaIoInputStream,
        _ output:JavaIoOutputStream,
        _ password:String,
        _ length:jlong ){
        //todo
    }
    
    static func compress(_ input:JavaIoInputStream,_ output:JavaIoOutputStream,_ size:jlong){
        let zip = 1
        let comGen = BCOpenpgpPGPCompressedDataGenerator(int: jint(zip))
        let comOut = comGen.open(with: output)
        let litGen = BCOpenpgpPGPLiteralDataGenerator()
        let litOut = litGen.open(
            with: comOut,
            withChar: BCOpenpgpPGPLiteralData.BINARY,
            with: BCOpenpgpPGPLiteralDataGenerator.CONSOLE,
            withLong: size,
            with: JavaUtilDate())
        BCUtilIoStreams.pipeAll(with: input, with: litOut)
        litOut?.close()
        comOut?.close()
    }
}
