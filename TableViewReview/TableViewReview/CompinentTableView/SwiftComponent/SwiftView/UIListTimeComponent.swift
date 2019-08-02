//
//  UIListTimeComponent.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/8/1.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class UIListTimeComponent: BaseAssemblyComponent {
    
    var listData : Array<Any>!
    let cellIdentifier = "ListCellIdentifier"

    override func assemblyComponentWillAppear(_ animated: Bool) {
        print("UIListTimeComponent WillAppear")
    }
    override func assemblyComponentWillDisappear(_ animated: Bool) {
        print("UIListTimeComponent WillDisappear")
    }
    
    override func setupComponent() {
        self.listData = (self.dataDictionary!["UIListTimeComponentKey"] as! Array<Any>)
        self.registerClass(ListTableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
    }
    
    //MARK:------TB
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ListTableViewCell
        cell.updateData(self.listData![indexPath.row] as AnyObject)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("UIListTimeComponent is select: \(indexPath.row)")
        let vc = SubDetailViewController()
        vc.view.frame = tableView.frame
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UILabel.init(frame: CGRect(x: 15, y: 0, width: self.view.frame.size.width, height: 30))
        sectionView.text = NSStringFromClass(self.classForCoder) + "-HeaderSection"
        sectionView.backgroundColor = UIColor.red
        sectionView.textColor = UIColor.white
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionView = UILabel.init(frame: CGRect(x: 15, y: 0, width: self.view.frame.size.width, height: 30))
        sectionView.text = NSStringFromClass(self.classForCoder) + "-FooterSection"
        sectionView.backgroundColor = UIColor.red
        sectionView.textColor = UIColor.white
        return sectionView
    }
}
