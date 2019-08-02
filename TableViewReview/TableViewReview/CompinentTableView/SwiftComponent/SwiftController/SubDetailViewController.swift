//
//  SubDetailViewController.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/8/1.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class SubDetailViewController: BaseAssemblyDispatcher {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Detail"
        self.view.backgroundColor = UIColor.white
    }
    
    
    /// 直接复用component
    ///
    ///
    override func components()->NSArray{
        return NSArray.init(objects: ["UITitleNumberComponentKey", NSStringFromClass(UITitleNumberComponent.classForCoder())])
    }
    

}
