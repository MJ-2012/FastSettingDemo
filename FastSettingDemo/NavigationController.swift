//
//  NavigationController.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/17.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

class NavigationController : UINavigationController {
    
    var frostedView:UIToolbar?
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layer.shadowRadius = 0.33
        self.navigationBar.layer.shadowOffset = CGSizeMake(0, 0.33)
        self.navigationBar.layer.shadowOpacity = 0.4
//        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true);
        self.navigationBar.setBackgroundImage(createImageWithColor(UIColor.clearColor()), forBarMetrics: .Default)
        
        let maskingView = UIView()
        maskingView.userInteractionEnabled = false
        maskingView.backgroundColor = UIColor(white: 0, alpha: 0.0);
        self.navigationBar.insertSubview(maskingView, atIndex: 0);
        
        maskingView.snp_makeConstraints{ (make) -> Void in
            make.left.bottom.right.equalTo(maskingView.superview!)
            make.top.equalTo(maskingView.superview!).offset(-20);
        }
        
        self.frostedView = UIToolbar()
        self.frostedView?.userInteractionEnabled = false
        self.frostedView?.clipsToBounds  = true
        maskingView.addSubview(self.frostedView!)
        self.frostedView?.snp_makeConstraints(closure: { (make) -> Void in
            make.edges.equalTo(maskingView)
        })
        
        self.KVOController.observe(MJColor.sharedInstance, keyPath: "style", options: [NSKeyValueObservingOptions.Initial,NSKeyValueObservingOptions.New]) { [weak self](nav, color, change) -> Void in
            
            self?.navigationBar.tintColor = MJColor.colors.MJ_navigationBarTintColor
            self?.navigationBar.titleTextAttributes = [
                NSFontAttributeName : UIFont.systemFontOfSize(18),
                NSForegroundColorAttributeName : MJColor.colors.MJ_TopicListTitleColor
            ]
            
            if MJColor.sharedInstance.style == MJColor.MJColorStyleDefault {
                UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
                self?.frostedView?.barStyle = .Default
                //全局键盘颜色
                UITextView.appearance().keyboardAppearance = .Light
                UITextField.appearance().keyboardAppearance = .Light
            }
            else{
                self?.frostedView?.barStyle = .Black
                UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true);
                UITextView.appearance().keyboardAppearance = .Dark
                UITextField.appearance().keyboardAppearance = .Dark
            }
        }
    }
}
