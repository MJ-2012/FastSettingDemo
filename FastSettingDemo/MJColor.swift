//
//  MJColor.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/16.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

func colorWithRGB(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 255)
}

func colorWithRGBA(r:CGFloat , g:CGFloat , b:CGFloat , a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a/255.0)
}

func createImageWithColor(color:UIColor) -> UIImage {
    return createImageWithColor(color,size:CGSizeMake(1,1))
}

func createImageWithColor(color:UIColor , size:CGSize)  -> UIImage {
    let rect = CGRectMake(0, 0, size.width, size.height)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, rect)
    let theImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return theImage
}


//使用协议 切换各种配色皮肤
protocol MJColorProtocol {
    var MJ_backgroundColor:UIColor { get }
    var MJ_navigationBarTintColor : UIColor { get }
    
    var MJ_cellBackgroundColor : UIColor { get }
    var MJ_cellTextLableColor : UIColor { get }
    var MJ_cellTextDetailLabelColr : UIColor { get }
    
    var MJ_buttonBackgroundColor : UIColor { get }
    var MJ_SeparatorColor : UIColor { get }
}


class MJDefaultColor : NSObject , MJColorProtocol  {
    static let sharedInstance = MJDefaultColor()
    private override init() {
        super.init()
    }
    
    var MJ_backgroundColor:UIColor { get { return colorWithRGB(242, g: 243, b: 245)} }
    var MJ_navigationBarTintColor : UIColor { get { return colorWithRGB(155, g: 155, b: 155)}}
    
    var MJ_cellBackgroundColor : UIColor { get { return colorWithRGB(255, g: 255, b: 255)}}
    var MJ_cellTextLableColor : UIColor { get { return colorWithRGB(15, g: 15, b: 15)}}
    var MJ_cellTextDetailLabelColr : UIColor { get { return colorWithRGB(53, g: 53, b: 53)}}
    
    var MJ_buttonBackgroundColor : UIColor { get { return colorWithRGB(201, g: 201, b: 201)}}
    
    var MJ_SeparatorColor : UIColor {
        get {
            return colorWithRGB(190, g: 190, b: 190)
        }
    }
}


class MJDarkColor : NSObject , MJColorProtocol {
    static let sharedInstance = MJDarkColor()
    
    var MJ_backgroundColor:UIColor { get { return colorWithRGB(0, g: 0, b: 0)} }
    var MJ_navigationBarTintColor : UIColor { get { return colorWithRGB(100, g: 100, b: 100)}}
    
    var MJ_cellBackgroundColor : UIColor { get { return colorWithRGB(0, g: 0, b: 0)}}
    var MJ_cellTextLableColor : UIColor { get { return colorWithRGB(100, g: 100, b: 100)}}
    var MJ_cellTextDetailLabelColr : UIColor { get { return colorWithRGB(130, g: 130, b: 130)}}
    
    var MJ_buttonBackgroundColor : UIColor { get { return colorWithRGB(100, g: 100, b: 100)}}
    
    var MJ_SeparatorColor : UIColor {
        get {
            return colorWithRGB(45, g: 45, b: 49)
        }
    }
}

class MJColor : NSObject {
    private static let STYLE_KEY = "styleKey"
    static let MJColorStyleDefault = "Default"
    static let MJColorStyleDark = "Dark"
    
    private static var _colors: MJColorProtocol?
    static var colors : MJColorProtocol {
        get {
            if let c = MJColor._colors {
                return c
            }else {
                if MJColor.sharedInstance.style == MJColor.MJColorStyleDark {
                  return MJDarkColor.sharedInstance
                }else {
                    return MJDefaultColor.sharedInstance
                }
            }
        }
        set {
            MJColor._colors = newValue
        }
    }

    // 对要视察的对象的属性加上dynamic关键字   KVO
    dynamic var style:String
    static let sharedInstance = MJColor()
    private override init() {
        if let style = MJSettings.sharedInstance[MJColor.STYLE_KEY] {
            self.style = style
        }else {
            self.style = MJColor.MJColorStyleDefault
        }
       super.init()
    }
    
    func setStyleAndSave(style:String) {
        
        print("\(self.style) .... :  \(style)")
        if self.style == style  {
            return
        }
        
        if style == MJColor.MJColorStyleDefault {
            MJColor.colors = MJDefaultColor.sharedInstance
        }else {
            MJColor.colors = MJDarkColor.sharedInstance
        }
        
        self.style = style
        MJSettings.sharedInstance[MJColor.STYLE_KEY] = style
        MJSettings.sharedInstance.save()
    }
}




