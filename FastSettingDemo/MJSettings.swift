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
    
    /*
    // 附属脚本（Subscripts）
    附属脚本 可以定义在类（Class）、结构体（structure）和枚举（enumeration）这些目标中，可以认为是访问对象、集合或序列的快捷方式
            MJSettings.sharedInstance["KEY"]
       介绍 http://www.swiftxuexi.com/swift/chapter2/12_Subscripts.html
    */
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