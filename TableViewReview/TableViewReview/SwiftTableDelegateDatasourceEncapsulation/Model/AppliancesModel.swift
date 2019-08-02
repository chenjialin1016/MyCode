//
//  AppliancesModel.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/30.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit
import HandyJSON

class AppliancesModel: HandyJSON {
    var color: String?
    var price: CGFloat = 0.0
    var name: String?
    
    required init() {}
}
