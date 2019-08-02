//
//  UITitleNumberComponent.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/8/1.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class UITitleNumberComponent: BaseAssemblyComponent {

    var listData : Array<Any>!
    let cellIdentifier = "TitleCellIdentifier"
    
    override func setupComponent() {
        self.doRequest()
        self.registerClass(TitleTableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
    }
    func doRequest(){
        listData = ["title1", "title2"]
    }
    
    //MARK:-----TB
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TitleTableViewCell
        cell.updateData(self.listData![indexPath.row] as AnyObject)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     print("UIListTimeComponent is select: \(indexPath.row)")
        #if KTestReloadTableViewComponent
            self.listData.append("测试新添加")
            self.reloadTableViewComponent()
        #elseif KTestReloadTableViewComponentRow
            self.listData[0] = "title1测试添加"
            self.reloadTableViewComponent(withRow: 0)
        #elseif KTestReloadTableView
            self.reloadTableView()
        #endif
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UILabel(frame: CGRect(x: 15, y: 0, width: self.view.frame.size.width, height: 30))
        sectionView.text = NSStringFromClass(self.classForCoder)+"-HeaderSection"
        sectionView.backgroundColor = UIColor.black
        sectionView.textColor = UIColor.white
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionView = UILabel(frame: CGRect(x: 15, y: 0, width: self.view.frame.size.width, height: 30))
        sectionView.text = NSStringFromClass(self.classForCoder)+"-FooterSection"
        sectionView.backgroundColor = UIColor.black
        sectionView.textColor = UIColor.white
        return sectionView
    }
}
