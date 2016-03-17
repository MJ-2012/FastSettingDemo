//
//  MJSettings.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/16.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

let keyPrefix = "me.fin.MJSettings."

class MJSettings : NSObject {
    static let sharedInstance = MJSettings()
    private override init() {
        super.init()
    }
    subscript(key:String) ->String? {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey(keyPrefix+key) as? String
        }
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: keyPrefix + key)
        }
    }
    
    func save() {
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}