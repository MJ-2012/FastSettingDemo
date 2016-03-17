//
//  BaseTableViewCell.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/16.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit


class BaseTableViewCell : UITableViewCell{
    
    var titleLabel : UILabel?
    var detailLabel : UILabel?
    var detailMarkImageView: UIImageView?
    var separator:UIImageView?
    
    
    var detailMarkHidden:Bool {
        get {
            if let mark = self.detailMarkImageView {
                return mark.hidden
            }
            return false
        }
        set {
            if self.detailMarkImageView?.hidden == newValue {
                return
            }
            self.detailMarkImageView?.hidden = newValue
            if newValue {
                self.detailMarkImageView!.snp_remakeConstraints(closure: { (make) -> Void in
                    make.width.height.equalTo(0)
                    make.centerY.equalTo(self.contentView)
                    make.right.equalTo(self.contentView).offset(-12)
                })
                
            }else {
                self.detailMarkImageView!.snp_remakeConstraints(closure: { (make) -> Void in
                    make.width.height.equalTo(20)
                    make.centerY.equalTo(self.contentView)
                    make.right.equalTo(self.contentView).offset(-12)
                })
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() -> Void{
        let selectedBackgroudView = UIView()
        self.selectedBackgroundView = selectedBackgroudView
        
        self.titleLabel = UILabel()
        self.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(self.titleLabel!)
        
        self.titleLabel!.snp_makeConstraints{ (make) -> Void in
            make.left.equalTo(self.contentView).offset(12)
            make.centerY.equalTo(self.contentView)
        }
        
        self.detailMarkImageView = UIImageView(image: UIImage(named: "ic_keyboard_arrow_right"))
        self.detailMarkImageView?.contentMode = .Center
        
        self.contentView.addSubview(self.detailMarkImageView!)
        self.detailMarkImageView!.snp_makeConstraints{ (make) -> Void in
            make.height.equalTo(24)
            make.width.equalTo(14)
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-12)
        }
        
        self.detailLabel = UILabel()
        self.detailLabel!.font = UIFont.systemFontOfSize(13)
        self.contentView.addSubview(self.detailLabel!)
        self.detailLabel?.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(self.detailMarkImageView!.snp_left).offset(-5)
            make.centerY.equalTo(self.contentView)
        })
        
        self.separator = UIImageView()
        self.contentView.addSubview(self.separator!)
        self.separator?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(SEPARATOR_HEIGHT)
        })
        
        self.KVOController.observe(MJColor.sharedInstance, keyPath: "style", options: [.Initial,.New]) {[weak self] (nav, color, change) -> Void in
            self?.backgroundColor = MJColor.colors.MJ_cellBackgroundColor
            self?.selectedBackgroundView!.backgroundColor = MJColor.colors.MJ_backgroundColor
            self?.titleLabel!.textColor = MJColor.colors.MJ_cellTextLableColor
            self?.detailMarkImageView!.tintColor = self?.titleLabel!.textColor
            self?.detailMarkImageView?.tintColor = self?.titleLabel?.textColor
            self?.detailLabel!.textColor = MJColor.colors.MJ_cellTextDetailLabelColr
            self?.separator!.image = createImageWithColor( MJColor.colors.MJ_SeparatorColor )
        }
    }
}



