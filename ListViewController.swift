//
//  ListViewController.swift
//  FastSettingDemo
//
//  Created by MieJie on 16/3/17.
//  Copyright © 2016年 MieJie. All rights reserved.
//

import UIKit

class ListViewController : UITableViewController {
    let dataArray : [String] = ["联发科的十核X20并没有看起来那么强联发科的十核X20并没有看起来那么强，高端梦难完联发科的十核X20并没有看起来那么强联发科的十核X20并没有看起来那么强，高端梦难完联发科的十核X20并没有看起来那么强联发科的十核X20并没有看起来那么强，高端梦难完",
        "电台十年井喷，播客的春天还有多远？除了近两年来各音乐平台关于版权和音乐人圈地似的烧钱大战，声音的价值在电台和播客的维度得到了近十年来最大的发展。",
        "手机市场的权力游戏传统的“中华酷联”解体已成定局，究竟原因何在？",
        "必读系列——股神巴菲特推荐给每个人的18本书 首发当巴菲特开始他的投资生涯时，他一直坚持阅读，每天阅读600—750页，最高甚至1000页。即使是现在，他仍然每天花大约80%的时间在阅读上。",
        "智能设备存安全漏洞，YunOS却通过了国家级检测？ 首发在今年的315晚会上，曝光了很多手机APP的信息安全以及智能硬件的安全漏洞问题，引起了各方广泛的注意。很多人越来越认识到，信息社会虽然让生活..."]
    override func viewDidLoad() {
        super.viewDidLoad()
        regClass(self.tableView, cell:ListTableViewCell.self)
        self.tableView.separatorStyle = .None
        self.KVOController.observe(MJColor.sharedInstance, keyPath: "style", options: [.Initial,.New]) {[weak self] (nav, color, change) -> Void in
            self?.view.backgroundColor = MJColor.colors.MJ_backgroundColor
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height = tableView.MJ_heightForCellWithIdentifier(ListTableViewCell.self, indexPath: indexPath, configuration: { (cell) -> Void in
            cell.bind( self.dataArray[indexPath.row])
        })
        return  height
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = getCell(tableView, cell: ListTableViewCell.self, indexPath: indexPath)
        cell.bind( self.dataArray[indexPath.row])
        return cell
    }
}
