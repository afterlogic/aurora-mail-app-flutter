import Flutter
import UIKit
import Foundation
import RxSwift
import BouncyCastle_ObjC

public class CryptoPlugin: NSObject, FlutterPlugin {
    let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    var composite = CompositeDisposable()
    var pgp = PgpApi()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "crypto_plugin", binaryMessenger: registrar.messenger())
        JavaSecuritySecurity.addProvider(with: BCJceProviderBouncyCastleProvider())
        let instance = CryptoPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let route = call.method.components(separatedBy: ".")
        let algorithm = route[0]
        let method = route[1]
        let arguments = call.arguments as! [Any]
        print(algorithm + "." + method)
        
        if(algorithm=="pgp"&&method=="stop"){
            self.pgp = PgpApi()
            self.composite.dispose()
            self.composite = CompositeDisposable()
            result("")
            return;
        }
        
        let disposable =  Single<Any>.create { emitter in
            do {
                let data  = try self.execute(algorithm: algorithm, method:method, arguments: arguments)
                emitter(SingleEvent.success(data))
            } catch let error {
                emitter(SingleEvent.error(error))
            }
            return Disposables.create {}
        }
        .subscribeOn(arguments.isEmpty ? MainScheduler.instance:scheduler)
        .observeOn(MainScheduler.instance)
        .subscribe(onSuccess: { (any) in
            result(any)
        },onError: { (error) in
            
            if error is MethodNotImplemented{
                result(FlutterMethodNotImplemented)
            }else if error is  CryptionError{
                result( FlutterError(code: "CryptionError", message: (error as! CryptionError).message, details: nil))
            }else{
                result( FlutterError(code: "error", message:  error.localizedDescription, details: nil))
            }
        })
        composite.insert(disposable)
    }
    
    private func execute(algorithm: String, method: String, arguments: [Any]) throws -> Any {
        switch algorithm {
        case "aes":
            let fileContent = arguments[0] as! FlutterStandardTypedData
            let key = arguments[1] as! String
            let iv = arguments[2] as! String
            let isLast = arguments[3] as! Bool
            let isDecrypt = method == "decrypt"
            let encryptedData = Aes.performCryption(
                Data.init(fileContent.data),
                Data.init(base64Encoded: key)!,
                Data.init(base64Encoded: iv)!,
                isLast,
                isDecrypt
            )
            return encryptedData.withUnsafeBytes {
                [UInt8](UnsafeBufferPointer(start: $0, count: encryptedData.count))
                
            }
        case "pgp":
            switch method {
            case "getKeyDescription":
                let data = arguments[0] as! String
                let info =  try self.pgp.getKeyDescription(  data.data(using: String.Encoding.utf8)!)
                return [info.emails,info.length,info.isPrivate]
            case "setTempFile":
                let data = arguments[0] as? String
                self.pgp.setTempFile(data)
                return ""
            case "setPublicKeys":
                let data = arguments[0] as? [String]
                try self.pgp.setPublicKeys( data)
                return ""
            case "setPrivateKey":
                let data = arguments[0] as? String
                try self.pgp.setPrivateKey(data)
                return ""
            case "decryptBytes":
                let data = arguments[0] as! FlutterStandardTypedData
                let password = arguments[1] as! String
                let result=try self.pgp.decryptBytes(Data.init(data.data), password)
               return  result.withUnsafeBytes {
                                  [UInt8](UnsafeBufferPointer(start: $0, count: result.count))
                              }
            
            case "decryptFile":
                let input = arguments[0] as! String
                let output = arguments[1] as! String
                let password = arguments[2] as! String
                
                try self.pgp.decryptFile(input, output, password)
                return ""
            case "encryptBytes":
                
                let data = arguments[0] as! FlutterStandardTypedData
                let passwordForSign = arguments[1] as? String
                let result = try self.pgp.encryptBytes(Data.init(data.data),passwordForSign)
                return  result.withUnsafeBytes {
                    [UInt8](UnsafeBufferPointer(start: $0, count: result.count))
                }
            case "encryptFile":
                let input = arguments[0] as! String
                let output = arguments[1] as! String
                let passwordForSign = arguments[2] as? String
                try self.pgp.encryptFile(input, output,passwordForSign)
                return ""
            case "createKeys":
                let length = arguments[0] as!   NSNumber
                let email = arguments[1] as! String
                let password = arguments[2] as! String
                return try self.pgp.createKeys(Int32(truncating: length), email, password)
            case "decryptSymmetricBytes":
                let data = arguments[0] as! FlutterStandardTypedData
                let password = arguments[1] as! String
                return try self.pgp.decryptSymmetricBytes(Data.init(data.data),password)
            case "decryptSymmetricFile":
                let input = arguments[0] as! String
                let output = arguments[1] as! String
                let password = arguments[2] as! String
                try self.pgp.decryptSymmetricFile(input,output, password)
                return ""
            case "encryptSymmetricBytes":
                let data = arguments[0] as! FlutterStandardTypedData
                let password = arguments[1] as! String
                return try self.pgp.encryptSymmetricBytes(Data.init(data.data),password)
            case "encryptSymmetricFile":
                let input = arguments[0] as! String
                let output = arguments[1] as! String
                let password = arguments[2] as! String
                try self.pgp.encryptSymmetricFile( input,output, password)
                return ""
            case "checkPassword":
                let password = arguments[0] as! String
                let privateKey = arguments[1] as! String
                return try self.pgp.checkPassword(password, privateKey)
            case "addSign":
                let text = arguments[0] as! String
                let password = arguments[1] as! String
                
                return try self.pgp.addSign(text, password)
            case "verifySign":
                let text = arguments[0] as! String
                
                return try self.pgp.verifySign(text)
            case "verifyResult":
                return [self.pgp.verifyResult()]
            default:
                break
            }
            break
        default:
            break
        }
        
        throw MethodNotImplemented()
    }
}

class CryptionError :Error{
    let message:String
    
    init(_ message:String="") {
        self.message=message
    }
}

class MethodNotImplemented :Error{}
