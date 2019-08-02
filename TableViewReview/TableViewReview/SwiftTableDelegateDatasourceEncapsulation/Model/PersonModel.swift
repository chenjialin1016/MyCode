//
//  PersonModel.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/30.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit
import HandyJSON

class PersonModel: HandyJSON {

    var gender: String?
    var age: Int = 0
    var country: String?
    var height: Int = 0
    var name: String?
    
    required init() {}
}
