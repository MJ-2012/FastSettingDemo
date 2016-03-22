//
//  HomeViewController.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/21.
//  Copyright © 2016年 MieJie. All rights reserved.
//





import UIKit

class HomeViewController : ListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Test"
        self.view.backgroundColor = MJColor.colors.MJ_backgroundColor
        setupNavigationItem()
    }

    func setupNavigationItem() {
        let leftButton = UIButton()
        leftButton.frame = CGRectMake(0, 0, 40, 40)
        leftButton.setImage(UIImage.imageUsedTempMode("ic_menu_36pt"), forState: .Normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        leftButton.addTarget(self, action: "leftHandle:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let rightButton = UIButton()
        rightButton.frame = CGRectMake(0, 0, 40, 40)
        rightButton.setImage(UIImage.imageUsedTempMode("ic_more_horiz_36pt"), forState: .Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        rightButton.addTarget(self, action: "rightHandle:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func leftHandle(sender:UIButton) {
        MJClient.sharedInstance.drawerController?.toggleLeftDrawerSideAnimated(true, completion: nil)
    }
    
    func rightHandle(sender:UIButton) {
        MJClient.sharedInstance.drawerController?.toggleRightDrawerSideAnimated(true, completion: nil)
    }
}
