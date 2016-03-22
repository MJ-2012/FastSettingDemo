//
//  MJClient.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/21.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit
import DrawerController

class MJClient : NSObject {
    static let sharedInstance = MJClient()
    
    var drawerController : DrawerController? = nil
    var centerViewController : HomeViewController? = nil
    var centerNavigation : NavigationController? = nil

    var topNavigationController : UINavigationController {
        get {
            return MJClient.getTopNavigationController(MJClient.sharedInstance.centerNavigation!)
        }
    }
    
    private class func getTopNavigationController(currentNavigationConroller : UINavigationController) -> UINavigationController {
        if let topNav = currentNavigationConroller.visibleViewController?.navigationController {
            if topNav != currentNavigationConroller && topNav.isKindOfClass(UINavigationController.self) {
                return getTopNavigationController(topNav)
            }
        }
        return currentNavigationConroller
    }
}