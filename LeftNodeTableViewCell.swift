//
//  LeftNodeTableViewCell.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/21.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

class LeftNodeTableViewCell : UITableViewCell {
    
    var nodeImageView : UIImageView?
    var nodeLabel : UILabel?
    var panel = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.selectionStyle = .None
        self.backgroundColor = UIColor.clearColor()
   
        self.contentView.addSubview(panel)
        panel.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(self.contentView)
            make.height.equalTo(55)
        }
        
        self.nodeImageView = UIImageView()
        panel.addSubview(self.nodeImageView!)
        self.nodeImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.size.equalTo(CGSizeMake(25, 25))
            make.centerY.equalTo(panel)
            make.left.equalTo(panel).offset(20)
        })
        
        self.nodeLabel = UILabel()
        self.nodeLabel?.font = UIFont.systemFontOfSize(16)
        panel.addSubview(self.nodeLabel!)
        self.nodeLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.height.equalTo(20)
            make.centerY.equalTo(panel.center)
            make.left.equalTo(self.nodeImageView!.snp_right).offset(20)
        })

        
        self.KVOController.observe(MJColor.sharedInstance, keyPath: "style", options: [.Initial,.New]) { [weak self](obj, color, change) -> Void in
            self?.configureColor()
        }
    }
    
    func configureColor() {
        self.panel.backgroundColor = MJColor.colors.MJ_NodeBackgroundColor
        self.nodeImageView?.tintColor = MJColor.colors.MJ_LeftNodeTintColor
        self.nodeLabel?.textColor = MJColor.colors.MJ_LeftNodeTintColor
    }
}
