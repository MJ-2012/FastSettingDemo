
//
//  ListTableViewCell.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/17.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

class ListTableViewCell : UITableViewCell {
    
    var tLabel:UILabel?
    var separator:UIImageView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() -> Void {
        tLabel = UILabel()
        tLabel?.numberOfLines = 0
        tLabel?.textColor = MJColor.colors.MJ_cellTextLableColor
        tLabel?.font = UIFont.systemFontOfSize(14)
        tLabel?.preferredMaxLayoutWidth =  SCREEN_WIDTH-20
        self.contentView.addSubview(tLabel!)
        tLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.edges.equalTo(self.contentView).offset(UIEdgeInsetsMake(5, 10, -5, -10))
        })
        
        
        self.separator = UIImageView()
        self.separator!.image = createImageWithColor( MJColor.colors.MJ_SeparatorColor )
        self.contentView.addSubview(self.separator!)
        self.separator?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(SEPARATOR_HEIGHT)
        })
        
    }
   
    func bind(content:String) {
        self.tLabel?.text = content
    }
}