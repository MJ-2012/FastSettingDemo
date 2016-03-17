//
//  UITableView+Extension.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/16.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

extension  NSObject {
    /*
    当前的类名字符串
    
    - return: 当前类名的字符串
    */
    
    public class func  Identifier()  -> String{
        return "\(self)"
    }
}

extension String {
    public var Length : Int {
        get {
            return self.characters.count
        }
    }
}

/*
  向UITableView 注册 UITableViewCell
  - parameter table : UITableView
  - parameter cell :  要注册的类名
*/
func regClass(tableView:UITableView , cell : AnyClass) -> Void {
   tableView.registerClass( cell, forCellReuseIdentifier: cell.Identifier());
}

/* 
   从tableView缓存中取出对应类型的Cell
   如果缓存中没有，则重新创建一个

  - parameter  tableView : tableView
  - parameter  cell : 要返回的Cell类型
  - parameter  indexPath : 索引
*/

func getCell< T : UITableViewCell>(tableView:UITableView , cell: T.Type , indexPath : NSIndexPath) -> T {
    return  tableView.dequeueReusableCellWithIdentifier("\(cell)", forIndexPath: indexPath) as! T
}