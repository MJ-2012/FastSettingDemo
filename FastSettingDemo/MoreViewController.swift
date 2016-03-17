//
//  MoreViewController.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/16.
//  Copyright © 2016年 MieJie. All rights reserved.
//
import UIKit

class MoreViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "More"
        self.view.backgroundColor = MJColor.colors.MJ_backgroundColor
        regClass(self.tableView, cell: BaseTableViewCell.self)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Color", style: UIBarButtonItemStyle.Done, target: self, action: "changeStyle")
        
        self.KVOController.observe(MJColor.sharedInstance, keyPath: "style", options: [.Initial,.New]) {[weak self] (nav, color, change) -> Void in
            self?.view.backgroundColor = MJColor.colors.MJ_backgroundColor
            self?.tableView.reloadData()
        }
    }
    
    var rightBtn : UIBarButtonItem?{
        get {
            return self.navigationItem.rightBarButtonItem
        }
    }
    
    func changeStyle() {
        if  MJColor.sharedInstance.style == MJColor.MJColorStyleDark {
            MJColor.sharedInstance.setStyleAndSave(MJColor.MJColorStyleDefault)
            self.rightBtn?.title = "Dark"
        }else {
            MJColor.sharedInstance.setStyleAndSave(MJColor.MJColorStyleDark)
            self.rightBtn?.title = "Bright"
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return [30,50,12,50,50,12,50,50,50][indexPath.row]
    }
    
    override  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = getCell(tableView, cell: BaseTableViewCell.self, indexPath: indexPath)
        cell.selectionStyle = .None
        cell.titleLabel?.text = ["","Item 0","","Item 1","Item 2", "","Item 3","Item 4","Version"][indexPath.row]
        
        if [0,2,5].contains(indexPath.row) {
            cell.backgroundColor = self.tableView.backgroundColor
        }else {
            cell.backgroundColor = MJColor.colors.MJ_cellBackgroundColor
        }
        
        if [6].contains(indexPath.row) {
            cell.detailMarkHidden = false
        }else {
            cell.detailMarkHidden = true
        }
        
        if indexPath.row == 8 {
            cell.detailLabel?.text = "\( NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String)" + " (Build " + "\(NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String)" + ")"
        }else if indexPath.row == 6 {
            cell.detailLabel?.text = "Simple List"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case  1,3,4,6:
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            print("indexPath: \(indexPath.row)")
            
            if indexPath.row == 6 {
                let vc  = ListViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        default:
            break
        }
    }
}