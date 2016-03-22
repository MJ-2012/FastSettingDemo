//
//  LeftHeadCell.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/21.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

class LeftHeadCell : UITableViewCell {
    var avatarImageView : UIImageView?
    var usernameLabel : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = .None
        
        self.avatarImageView = UIImageView()
        self.avatarImageView!.backgroundColor = UIColor(white: 0.9, alpha: 0.3)
        self.avatarImageView!.layer.borderWidth = 15
        self.avatarImageView!.layer.borderColor = UIColor(white: 1, alpha: 0.6).CGColor
        self.avatarImageView!.layer.masksToBounds = true
        self.avatarImageView!.layer.cornerRadius = 38
        self.contentView.addSubview(self.avatarImageView!)
        self.avatarImageView!.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.contentView).offset(CGPointMake(0, -8))
            make.width.height.equalTo(self.avatarImageView!.layer.cornerRadius * 2)
        }
        
        self.usernameLabel = UILabel()
        self.usernameLabel?.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(self.usernameLabel!)
        self.usernameLabel!.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.avatarImageView!.snp_bottom).offset(10)
            make.centerX.equalTo(self.avatarImageView!)
        }
        
        self.KVOController.observe(MJColor.sharedInstance, keyPath: "style", options: [NSKeyValueObservingOptions.Initial,NSKeyValueObservingOptions.New]) { [weak self ](nav, color, change) -> Void in
            self?.usernameLabel?.textColor = MJColor.colors.MJ_TopUserNameColor
        }
    }
}