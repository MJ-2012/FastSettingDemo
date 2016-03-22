//
//  LeftViewController.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/21.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit
import FXBlurView

class LeftViewController : UIViewController,UITableViewDataSource , UITableViewDelegate{
    
    var backgroundImageView : UIImageView?
    var frostedView = FXBlurView()
    
    private var _tableView :UITableView!
    private var tableView : UITableView  {
        get{
            if (_tableView != nil) {
                return _tableView
            }
            _tableView = UITableView()
            _tableView.backgroundColor = UIColor.clearColor()
            _tableView.estimatedRowHeight = 100
            _tableView.separatorStyle = .None
            
            regClass(self.tableView, cell: LeftNodeTableViewCell.self)
            regClass(self.tableView, cell: LeftHeadCell.self)
            _tableView.delegate = self
            _tableView.dataSource = self
            
            return _tableView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = MJColor.colors.MJ_backgroundColor
        setup()
    }
    
    func setup() {
       
        self.backgroundImageView = UIImageView()
        self.backgroundImageView!.frame = self.view.frame
        self.backgroundImageView!.contentMode = .ScaleToFill
        self.view.addSubview(self.backgroundImageView!)
        
        frostedView.underlyingView = self.self.backgroundImageView!
        frostedView.dynamic = false
        frostedView.tintColor = UIColor.blackColor()
        frostedView.frame = self.view.frame
        self.view.addSubview(frostedView)
        
        self.view.addSubview(self.tableView)
        self.tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
        self.KVOController.observe(MJColor.sharedInstance, keyPath: "style", options: [NSKeyValueObservingOptions.Initial,NSKeyValueObservingOptions.New]) { [weak self](nav, color, change) -> Void in
            if MJColor.sharedInstance.style == MJColor.MJColorStyleDark {
                self?.backgroundImageView!.image = UIImage(named: "12.jpg")
            }else {
                self?.backgroundImageView!.image = UIImage(named: "32.jpg")
            }
            self?.frostedView.updateAsynchronously(true, completion: nil)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return [1,3,2][section]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 2 {
            return 55+10
        }
        return [180,55 + SEPARATOR_HEIGHT,55 + SEPARATOR_HEIGHT][indexPath.section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = getCell(tableView, cell: LeftHeadCell.self, indexPath: indexPath)
            cell.usernameLabel?.text = "梅杰超"
            return cell
        }else if indexPath.section == 1 {
            let cell = getCell(tableView, cell: LeftNodeTableViewCell.self, indexPath: indexPath)
            cell.nodeLabel?.text = ["个人中心","消息提醒","我的收藏"][indexPath.row]
            
            cell.nodeImageView?.image = UIImage.imageUsedTempMode(["ic_face","ic_notifications_none","ic_turned_in_not"][indexPath.row])
            
            return cell
        }else {
            let cell = getCell(tableView, cell: LeftNodeTableViewCell.self, indexPath: indexPath)
            cell.nodeLabel?.text = ["节点","更多"][indexPath.row]
            cell.nodeImageView?.image = UIImage.imageUsedTempMode(["ic_navigation","ic_settings_input_svideo"][indexPath.row])
            return cell
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("............\(indexPath)")
        
        if indexPath.section == 2 && indexPath.row == 1  {
            let vc = MoreViewController()
            MJClient.sharedInstance.centerNavigation?.pushViewController(vc, animated: true)
            MJClient.sharedInstance.drawerController?.closeDrawerAnimated(true, completion: nil)
        }
    }
    
}
