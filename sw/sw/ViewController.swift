//
//  ViewController.swift
//  sw
//
//  Created by strong on 2017/5/5.
//  Copyright © 2017年 strong. All rights reserved.

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var rightTableView : UITableView?
    var leftTableView : UITableView?
    
    let leftTableSource = ["个人劳保","工业安全","管材管件","泵","清洁用品","阀门"]
    let rightTableSource = [
        ["header":"个人劳保","title":["足部防护","手部防护","防护镜","身体防护","眼部防护","护目镜","口罩面罩面屏","耳塞耳罩","手套","坠落防护"]],
        ["header":"工业安全","title":["锁具","安全防护用品","冲淋洗眼设备","标识"]],
        ["header":"管材管件","title":["防火垃圾桶及配件","绕管器","软管","快速接头","食品输送管","耐油水气多用途软管"]],
        ["header":"泵","title":["气动泵","排水泵","卧式端吸泵","电动泵","手动泵","循环泵"]],
        ["header":"清洁用品","title":["纸类产品","清洁工具","清洁设备","个人清洁","扳手组套","梅花扳手","气动扳手"]],
        ["header":"阀门","title":["针型阀","控制阀","过滤器","截止阀","闸阀","调节阀"]]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI基本设置
        setupView()
    }
    //UI基本设置
    func setupView(){
        //左tableview
        self.leftTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: self.view.frame.size.height), style: .plain)
        self.leftTableView?.delegate = self
        self.leftTableView?.dataSource = self
        self.view.addSubview(self.leftTableView!)
        //右tableview
        self.rightTableView = UITableView(frame: CGRect(x:100, y: 0, width: self.view.frame.size.width - 100, height: self.view.frame.size.height), style: .plain)
        self.rightTableView?.delegate = self
        self.rightTableView?.dataSource = self
        self.view.addSubview(self.rightTableView!)
    }
}
//MARK:数据源与代理
extension ViewController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.rightTableView {
            return self.rightTableSource.count
        }
        else {
            return 1}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.leftTableView {
            return self.leftTableSource.count
        }
        else{
            let sd = self.rightTableSource[section]["title"] as! NSArray
            return  sd.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let str = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: str)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: str)
        }
        if tableView == self.leftTableView {
            cell?.textLabel?.text = self.leftTableSource[indexPath.row]
        }
        else if tableView == self.rightTableView{
            let sd = self.rightTableSource[indexPath.section]["title"] as! [String]
            cell?.textLabel?.text = sd[indexPath.row]
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.rightTableView {
            return self.rightTableSource[section]["header"] as! String?
        }
        else{
        return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == self.rightTableView {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: (self.rightTableView?.frame.size.width)!, height: 40))
            label.backgroundColor = UIColor.green
            label.text = self.rightTableSource[section]["header"] as! String?
            label.textAlignment = .center
            label.textColor = UIColor.red
            return label
        }
        else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.leftTableView {
            //点击左cell，右边cell响应滚动
            let indexpath = NSIndexPath(row: 0, section: indexPath.row) as IndexPath
            self.rightTableView?.scrollToRow(at: indexpath, at: .top, animated: true)
        }
    }
}
