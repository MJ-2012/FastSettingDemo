//
//  RightViewController.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/21.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit
import FXBlurView

class RightViewController : UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    let data : [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T"]
    
    var backgroundImageView:UIImageView?
    var frostedView = FXBlurView()
    
    private var _tableView :UITableView!
    private var tableView : UITableView {
        get {
            if _tableView != nil {
                return _tableView
            }
            
            _tableView = UITableView()
            _tableView.backgroundColor = UIColor.clearColor()
            _tableView.estimatedRowHeight = 100
            _tableView.separatorStyle = .None
            
            regClass(self.tableView, cell:RightNodeTableViewCell.self)
            
            _tableView.delegate = self
            _tableView.dataSource = self
            
            return _tableView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.view.backgroundColor = MJColor.colors.MJ_backgroundColor;
        
        self.backgroundImageView = UIImageView()
        self.backgroundImageView!.frame = self.view.frame
        self.backgroundImageView!.contentMode = .Left
        view.addSubview(self.backgroundImageView!)
        
        frostedView.underlyingView = self.backgroundImageView!
        frostedView.dynamic = false
        frostedView.frame = self.view.frame
        frostedView.tintColor = UIColor.blackColor()
        self.view.addSubview(frostedView)
        
        self.view.addSubview(self.tableView);
        self.tableView.snp_makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.equalTo(self.view);
        }
        self.KVOController.observe(MJColor.sharedInstance, keyPath: "style", options: [.Initial,.New]) {[weak self] (nav, color, change) -> Void in
            if MJColor.sharedInstance.style == MJColor.MJColorStyleDefault {
                self?.backgroundImageView?.image = UIImage(named: "32.jpg")
            }
            else{
                self?.backgroundImageView?.image = UIImage(named: "12.jpg")
            }
            self?.frostedView.updateAsynchronously(true, completion: nil)
        }
        
        self.tableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 32))
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55 + SEPARATOR_HEIGHT
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = getCell(tableView, cell: RightNodeTableViewCell.self, indexPath: indexPath)
        cell.nodeNameLabel?.text = data[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MJClient.sharedInstance.drawerController!.closeDrawerAnimated(true, completion: nil)
    }
}
