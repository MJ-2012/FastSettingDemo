//
//  MJUsersKeychain.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/18.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit
import KeychainSwift

class MJUsersKeyChain {
    static let sharedInstance = MJUsersKeyChain()
    private let keychain = KeychainSwift()
    
    private var users:[String:AccountModel] = [:]
    
    private init() {
        getUsersDict()
    }
    
    static let usersKey = "MJ.usersKey"
    func getUsersDict() -> [String:AccountModel] {
        if users.count <= 0 {
            if let data = keychain.getData(MJUsersKeyChain.usersKey) {
                let archiver = NSKeyedUnarchiver(forReadingWithData: data)
                let usersDict = archiver.decodeObject()
                archiver.finishDecoding()
                
                if let  usersDict = usersDict as? [String : AccountModel] {
                    self.users = usersDict
                }
            }
        }
        return self.users
    }
    
    func addUser(username:String , passwd:String, avatar:String) {
        let user = AccountModel()
        user.username = username
        user.password = passwd
        user.avatar = avatar
        self.addUser(user)
    }
    
    func addUser(user:AccountModel) {
        if let username = user.username , let _ = user.password {
            self.users[username] = user
            self.saveUsersDict()
        }
    }
    
    func saveUsersDict() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
         archiver.encodeObject(self.users)
        archiver.finishEncoding()
        keychain.set(data, forKey: MJUsersKeyChain.usersKey)
    }
    
    func removerUser(username:String) {
        self.users.removeValueForKey(username)
    }
    
    func removeAll() {
        self.users = [:]
        self.saveUsersDict()
    }
    
    func updata(username:String,passwd:String? , avatar:String?) {
        if let user = self.users[username] {
            if let _password = passwd {
                user.password = _password
            }
            if let _avatar = avatar {
                user.avatar = _avatar
            }
            self.saveUsersDict()
        }
    }
}




class AccountModel : NSObject, NSCoding {
    var username : String?
    var password : String?
    var avatar : String?
    
    override init() {
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.username, forKey: "username")
        aCoder.encodeObject(self.password, forKey: "password")
        aCoder.encodeObject(self.avatar, forKey: "avatar")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.username = aDecoder.decodeObjectForKey("username") as? String
        self.password = aDecoder.decodeObjectForKey("password") as? String
        self.avatar = aDecoder.decodeObjectForKey("avatar") as? String
    }
}