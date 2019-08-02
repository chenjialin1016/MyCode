//
//  MainViewController.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/8/1.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class MainViewController: BaseAssemblyDispatcher {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "AssemblyTableView"
        self.tableView!.cellMarginType = BaseCellMarginType.BaseCellMarginType_List
        let listData = ["UIListTimeComponents 2016-02-15@1","UIListTimeComponents 2016-02-15@2","UIListTimeComponents 2016-02-15@3","UIListTimeComponents 2016-02-15@4","UIListTimeComponents 2016-02-15@5","UIListTimeComponents 2016-02-15@6","UIListTimeComponents 2016-02-15@7","UIListTimeComponents 2016-02-15@8","UIListTimeComponents 2016-02-15@9","UIListTimeComponents 2016-02-15@10",
                         "UIListTimeComponents 2016-02-15@11","UIListTimeComponents 2016-02-15@12","UIListTimeComponents 2016-02-15@13","UIListTimeComponents 2016-02-15@14","UIListTimeComponents 2016-02-15@15",
                          "UIListTimeComponents 2016-02-15@16","UIListTimeComponents 2016-02-15@17","UIListTimeComponents 2016-02-15@18","UIListTimeComponents 2016-02-15@19","UIListTimeComponents 2016-02-15@20",
                           "UIListTimeComponents 2016-02-15@21"]
        self.dataDictionary = ["UIListTimeComponentKey":listData]
    }
    
    override func components() -> NSArray {
        return NSArray.init(objects: "UIListTimeComponentKey", NSStringFromClass(UIListTimeComponent.classForCoder()), "UITitleNumberComponentKey", NSStringFromClass(UITitleNumberComponent.classForCoder()))
    }
   
}
