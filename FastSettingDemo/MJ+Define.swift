//
//  MJ+Define.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/16.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

let EMPTY_STRING = ""
let SEPARATOR_HEIGHT = 1.0 / UIScreen.mainScreen().scale

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height


func dispatch_sync_safely_main_queue(block: ()->()) {
    if NSThread.isMainThread() {
        block()
    }else {
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            block()
        })
    }
}