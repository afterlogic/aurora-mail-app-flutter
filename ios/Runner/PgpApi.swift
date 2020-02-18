//
//  PgpApi.swift
//  Runner
//
//  Created by Alexander Orlov on 26.12.2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import DMSOpenPGP
import BouncyCastle_ObjC

class PgpApi{
    
    let pgp = Pgp()
    var privateKey : String?=nil
    var publicKey : [String]?=nil
    var tempFile : String?=nil
    
    func setPrivateKey(_ data:String?) throws{
        privateKey=data
    }
    
    func setPublicKeys(_ data:[String]?) throws{
        
        publicKey=data
    }
    
    func decryptBytes(_ data:Data,_ password:String)throws->Data{
        let byteArray = IOSByteArray(nsData: data)!
        let input = JavaIoByteArrayInputStream(byteArray: byteArray)
        let output = JavaIoByteArrayOutputStream()
        try  decrypt(input,output,password)
        return output.toByteArray().toNSData()
    }
    
    func decryptFile(_ inputFile:String,_ outputFile:String,_ password:String)throws{
        let outfile=JavaIoFile(nsString: outputFile)
        let infile=JavaIoFile(nsString: inputFile)
        
        outfile.createNewFile()
        
        let input = JavaIoFileInputStream(  javaIoFile:infile)
        let output = JavaIoFileOutputStream(  javaIoFile: outfile)
        try decrypt(input,output,password)
    }
    
    func encryptBytes(_ data:Data,_ passwordForSign:String?)throws->Data{
        let byteArray = IOSByteArray(nsData: data)!
        let input = JavaIoByteArrayInputStream(byteArray: byteArray)
        let input2 = JavaIoByteArrayInputStream(byteArray: byteArray)
        let output = JavaIoByteArrayOutputStream()
        try  encrypt(input,input2,output,passwordForSign)
        return output.toByteArray().toNSData()
    }
    
    func encryptFile(_ inputFile:String,_ outputFile:String,_ passwordForSign:String?)throws{
        
        let outfile=JavaIoFile(nsString: outputFile)
        let infile=JavaIoFile(nsString: inputFile)
        
        outfile.createNewFile()
        
        let input = JavaIoFileInputStream(  javaIoFile: infile)
        let input2 = JavaIoFileInputStream(  javaIoFile: infile)
        let output = JavaIoFileOutputStream(  javaIoFile: outfile)
        try encrypt(input,input2,output,passwordForSign)
    }
    
    func encrypt(_ input:JavaIoInputStream,_ input2:JavaIoInputStream,_ output:JavaIoOutputStream,_ passwordForSign:String?) throws {
        assert(publicKey != nil)
        if(passwordForSign != nil){
            assert(privateKey != nil)
        }
        try pgp.encrypt(input,input2,output,publicKey!,privateKey,passwordForSign)
    }
    func decrypt(_ input:JavaIoInputStream,_ output:JavaIoOutputStream,_ password:String) throws {
        assert(privateKey != nil)
        try pgp.decrypt(input,output,privateKey!,password,publicKey?.first!)
    }
    func getKeyDescription(_ key:Data) throws->KeyInfo{
        return try pgp.getKeyDescription(key)
    }
    func createKeys(_ length:Int32,_ email:String,_ password:String) throws->[String]{
        return try pgp.createKeys(length,email,password)
    }
    
    func setTempFile(_ file:String?){
        tempFile=file
    }
    
    func encryptSymmetricBytes(_ data:Data,_ password:String)throws ->Data {
        let byteArray = IOSByteArray(nsData: data)!
        let input = JavaIoByteArrayInputStream(byteArray: byteArray)
        let output = JavaIoByteArrayOutputStream()
        try encryptSymmetric(input,output,password,jlong(data.count))
        return output.toByteArray().toNSData()
    }
    func encryptSymmetricFile(_ inputFile:String,_ outputFile:String,_ password:String) throws {
        let outfile=JavaIoFile(nsString: outputFile)
        let infile=JavaIoFile(nsString: inputFile)
        
        outfile.createNewFile()
        
        let input = JavaIoFileInputStream(  javaIoFile: infile)
        let output = JavaIoFileOutputStream(  javaIoFile: outfile)
        try encryptSymmetric(input,output,password,infile.length())
    }
    func encryptSymmetric(
        _ input:JavaIoInputStream,
        _ output:JavaIoOutputStream,
        _ password:String,
        _ length:jlong
    ) throws{
        assert(tempFile != nil)
        let temp=JavaIoFile(nsString: tempFile)
        pgp.encryptSymetric(input,output,temp,password,length)
    }
    
    func decryptSymmetricBytes(_ data:Data,_ password:String) throws->Data{
        let byteArray = IOSByteArray(nsData: data)!
        let input = JavaIoByteArrayInputStream(byteArray: byteArray)
        let output = JavaIoByteArrayOutputStream()
        try decryptSymmetric(input,output,password,jlong(data.count))
        return output.toByteArray().toNSData()
    }
    func decryptSymmetricFile(_ inputFile:String,_ outputFile:String,_ password:String) throws{
        let outfile=JavaIoFile(nsString: outputFile)
        let infile=JavaIoFile(nsString: inputFile)
        
        outfile.createNewFile()
        
        let input = JavaIoFileInputStream(  javaIoFile: infile)
        let output = JavaIoFileOutputStream(  javaIoFile: outfile)
        try decryptSymmetric(input,output,password,infile.length())
    }
    func decryptSymmetric(
        _ input:JavaIoInputStream,
        _ output:JavaIoOutputStream,
        _ password:String,
        _ length:Int64
    ) throws {
        assert(tempFile != nil)
        let temp=JavaIoFile(nsString: tempFile)
        pgp.decryptSymmetric(input,output,temp,password,length)
    }
    
    func checkPassword(_ password:String,_ privateKey:String)throws -> Bool {
        return pgp.checkPassword(password,privateKey)
    }
    
    func addSign(_ text:String,_ password:String)throws -> String {
        return try pgp.addSign(text,password,privateKey!)
     }
    
    func verifySign(_ text:String)throws -> String {
        return try pgp.verifySign(text,publicKey!.first!)
      }
    func verifyResult()->Bool{
       return pgp.lastVerifyResult
    }
}
