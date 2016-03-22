
//
//  UIImage+Extension.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/21.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageUsedTempMode(named:String) -> UIImage? {
        let image = UIImage(named: named)
        if image == nil {
            return nil
        }
        return image!.imageWithRenderingMode(.AlwaysTemplate)
    }
}