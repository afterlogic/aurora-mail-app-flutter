import Foundation
import DMSOpenPGP
import BouncyCastle_ObjC

class  Pgp {
    
    var lastVerifyResult:Bool=false
    
    func decrypt(_ input:JavaIoInputStream,_ output:JavaIoOutputStream,_ privateKey:String,_ password:String,_ publicKey:String?) throws {
        lastVerifyResult = true
        let secretKeyRing = try DMSPGPKeyRing.secretKeyRing(from: privateKey, password: password)
        let privateKey = secretKeyRing.getSecretKey()
        let decryptor = try ByteDMSPGPDecryptor(input)
        try decryptor.decrypt( privateKey!,  password,output)
        input.reset()
        if(output is JavaIoByteArrayOutputStream && publicKey != nil ){
            let keyRing = try DMSPGPKeyRing(armoredKey: publicKey!)
            let message =  (output as! JavaIoByteArrayOutputStream).toByteArray()?.toNSData()?.base64EncodedString()
            
            let signatureVerifier = DMSPGPSignatureVerifier(message: message!,
                                                            onePassSignatureList: decryptor.onePassSignatureList,
                                                            signatureList: decryptor.signatureList)
            
            let result = signatureVerifier.verifySignature(message:message!,use: keyRing.publicKeyRing)
            switch result {
            case .invalid:
                lastVerifyResult = false
                break
            default:
                lastVerifyResult = true
                break
            }
            
        }else{
            lastVerifyResult = true
        }
        
    }
    
    func encrypt(_ input:JavaIoInputStream,_ input2:JavaIoInputStream,_ output:JavaIoOutputStream,_ publicKey: [String],_ privateKey:String?,_ passwordForSign:String?) throws  {
        var publicKeys:[BCOpenpgpPGPPublicKeyRing]=[]
        try publicKey.forEach { (key) in
            let publicKeyRing = try DMSPGPKeyRing.publicKeyRing(from: key)
            publicKeys.append(publicKeyRing)
        }
        
        var secretKeyRing:BCOpenpgpPGPSecretKeyRing?
        var encryptor:DMSPGPEncryptor?
        if(privateKey != nil && passwordForSign != nil){
            secretKeyRing =  try DMSPGPKeyRing.secretKeyRing(
                from: privateKey!,
                password: passwordForSign!
            )
            encryptor = try DMSPGPEncryptor(
                publicKeyRings: publicKeys,
                secretKeyRing:secretKeyRing!,
                password: passwordForSign!
            )
        }else{
            encryptor = try DMSPGPEncryptor(publicKeyRings: publicKeys )
        }
        
        try encryptor!.encrypt(input,input2,output)
    }
    
    func getKeyDescription(_ key:Data) throws->KeyInfo {
        do {
            let key = try readPublicKey(key)
            let userIds = key.userIDs
            let length = key.getBitStrength()
            return KeyInfo(emails:userIds,length: Int(length),isPrivate: false)
        } catch  {
            let key = try readPrivateKey(key)
            let userIds = key.userIDs
            let length = key.getPublicKey().getBitStrength()
            return KeyInfo(emails:userIds,length: Int(length),isPrivate: true)
        }
    }
    
    func createKeys(_ length:Int32,_ email:String,_ password:String)throws ->[String]{
        let generateData = GenerateKeyData(name: "", email: email, password: password, masterKey: KeyData(strength: Int(length)), subkey: KeyData(strength: Int(length)))
        let pair = try DMSPGPKeyRingFactory(generateKeyData: generateData).keyRing
        
        return [pair.publicKeyRing.armored(),pair.secretKeyRing!.armored()]
    }
    
    func readPublicKey(_ key:Data) throws->BCOpenpgpPGPPublicKey {
        let byteArray = IOSByteArray(nsData: key)!
        var input:JavaIoInputStream = JavaIoByteArrayInputStream(byteArray: byteArray)
        input = BCOpenpgpPGPUtil.getDecoderStream(with: input)
        let ring=BCOpenpgpPGPPublicKeyRingCollection.init(javaIoInputStream: input,with: BCOpenpgpOperatorBcBcKeyFingerprintCalculator())
        let rIt =  ring.getKeyRings()!
        
        while ( rIt.hasNext()){
            let kRing=rIt.next() as! BCOpenpgpPGPPublicKeyRing
            let kIt = kRing.getPublicKeys()!
            while( kIt.hasNext()){
                let k  = kIt.next() as! BCOpenpgpPGPPublicKey
                if(k.isEncryptionKey()){
                    return k;
                }
            }
        }
        throw CryptionError();
    }
    func readPrivateKey(_ key:Data)throws->BCOpenpgpPGPSecretKey{
        let byteArray = IOSByteArray(nsData: key)!
        let input:JavaIoInputStream = JavaIoByteArrayInputStream(byteArray: byteArray)
        
        return BCOpenpgpPGPSecretKeyRing(
            javaIoInputStream:BCOpenpgpPGPUtil.getDecoderStream(with: input),
            with: BCOpenpgpOperatorBcBcKeyFingerprintCalculator()
        ).getSecretKey()
        
    }
    
    func checkPassword(_ password:String,_ privateKey:String) -> Bool {
        do {
            try DMSPGPKeyRing.secretKeyRing(from: privateKey, password: password)
            return true
        } catch  {
            return false
            
        }
    }
    func decryptSymmetric(
        _ input:JavaIoInputStream,
        _ output:JavaIoOutputStream,
        _ temp:JavaIoFile,
        _ password:String,
        _ length:jlong){
        SymmetricPgp.decrypt(input,output,password,length)
    }
    func encryptSymetric(
        _ input:JavaIoInputStream,
        _ output:JavaIoOutputStream,
        _ temp:JavaIoFile,
        _ password:String,
        _ length:jlong ){
        SymmetricPgp.encrypt(input,output,temp,password,length)
    }
    
    func addSign(_ text:String,_ password:String,_  privateKey:String)throws -> String {
        let keyRing = try DMSPGPKeyRing(armoredKey: privateKey)
        let text = text.removingRegexMatches(pattern: "\n", replaceWith: "\r\n")
        let encryptorWithSignature = try DMSPGPEncryptor(
            secretKeyRing: (keyRing.secretKeyRing!),
            password:  password)
        return try encryptorWithSignature.encrypt(fullMessage: text)
    }
    
    func verifySign(_ text:String,_ publicKey:String)throws -> String {
        lastVerifyResult = true
        let keyRing = try DMSPGPKeyRing(armoredKey: publicKey)
        let verifier=try ValidDMSPGPClearTextVerifier(cleartext: text)
        let signatureVerifier = verifier.signatureVerifier
        
        let verifyResult=signatureVerifier.verifySignature(message:verifier.message,use: keyRing.publicKeyRing)
        switch verifyResult {
        case .invalid:
            lastVerifyResult = false
            break
        default:
            lastVerifyResult = true
            break
        }
        return verifier.message
    }
}

class KeyInfo {
    let emails:[String]
    let length:Int
    let isPrivate:Bool
    
    init(emails:[String],length:Int,isPrivate:Bool) {
        self.emails=emails
        self.length=length
        self.isPrivate=isPrivate
    }
}

