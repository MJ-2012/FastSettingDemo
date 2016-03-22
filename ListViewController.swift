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
        "智能设备存安全漏洞，YunOS却通过了国家级检测？ 首发在今年的315晚会上，曝光了很多手机APP的信息安全以及智能硬件的安全漏洞问题，引起了各方广泛的注意。很多人越来越认识到，信息社会虽然让生活...",
    "实现“十三五”宏伟目标，时间紧任务重；需要凝聚共识，充分发挥一切积极因素，为干事创业提供良好的氛围。所以，习近平总书记不仅提出要净化政治生态，还首次提出要净化经济生态。3月4日，他在参加全国政协十二届四次会议民建、工商联界委员联组会时指出：“反腐败斗争有利于净化政治生态，也有利于净化经济生态，有利于理顺市场秩序、还市场以本来的面目，把被扭曲了的东西扭回来。”请随“学习中国”小编一起学习。",
    "3月20日，山东食品药品监管部门经对警方提供的，关于庞某非法经营疫苗案查封疫苗品种的清单进行核实，发现实有疫苗12种、免疫球蛋白2种、治疗性生物制品1种。12种疫苗无第一类疫苗，全部为第二类疫苗，分别为冻干人用狂犬病疫苗（Vero细胞）、脊髓灰质炎灭活疫苗、b型流感嗜血杆菌结合疫苗、乙型脑炎减毒活疫苗、腮腺炎减毒活疫苗、冻干乙型脑炎灭活疫苗（vero细胞）、重组乙型肝炎疫苗（CHO细胞、汉逊酵母）、A群C群脑膜炎球菌结合疫苗、ACYW135群脑膜炎球菌多糖疫苗、水痘减活疫苗、口服轮状病毒活疫苗、甲型肝炎灭活疫苗（人二倍体细胞）;2种免疫球蛋白分别为狂犬病人免疫球蛋白、乙型肝炎人免疫球蛋白;1种治疗性生物制品，为细菌溶解物。（央视记者余静英）",
        "写在前面的话：本熊掐指细细一算，距离小米5发布会也有快一个月了，这时候出来讨论一下这些个所谓“黑科技”，应该不会被一群水军喷子冠以“洗地”“米吹”“脑残粉”的恶名了吧……在上个月的发布会后，小米5的一系列广告再次被喷得体无完肤，这基本上是每次发布会后的“规定动作”。从坊间舆论导向看来，似乎这次雷军的“探索黑科技”犯了众怒：快充3.0和全网通3.0那是人家高通的，只要用高通820芯片都有，而相机四轴防抖和DTI像素隔离都是索尼的技术，只要肯花钱买索尼的摄像头都能用上，和你小米有什么相干？一时间“戳破小米的黑科技谎言”似乎成了媒体们最喜欢的标题，而在我来看，记者们的这种反应可以用八个字来形容，那就是“情理之外，意料之中”。"]
    
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
