//
//  RightNodeTableViewCell.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/22.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

class RightNodeTableViewCell : UITableViewCell {
    
    var nodeNameLabel : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.selectionStyle = .None
        self.backgroundColor = UIColor.clearColor()
        
        let panel = UIView()
        self.contentView.addSubview(panel)
        panel.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(self.contentView)
            make.height.equalTo(55)
        }
        
        self.nodeNameLabel = UILabel()
        self.nodeNameLabel?.textAlignment = .Left
        self.nodeNameLabel?.font = UIFont.systemFontOfSize(16)
        panel.addSubview(self.nodeNameLabel!)
        self.nodeNameLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(panel).offset(-25)
            make.centerY.equalTo(panel)
        })
        
        self.KVOController.observe(MJColor.sharedInstance, keyPath: "style", options: [NSKeyValueObservingOptions.Initial,NSKeyValueObservingOptions.New]) { [weak self](nav, color, change) -> Void in
            panel.backgroundColor = MJColor.colors.MJ_LeftNodeBackgroundColor
            self?.nodeNameLabel!.textColor = MJColor.colors.MJ_LeftNodeTintColor
        }
    }
}