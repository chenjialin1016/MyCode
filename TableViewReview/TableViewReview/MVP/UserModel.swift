//
//  UserModel.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/31.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    
    var age: Int = 0
    var name: String?
    var email: String?
    
    init(_ age: Int, _ name: String, _ email: String) {
        self.age = age
        self.name = name
        self.email = email
    }
    
    //模拟获取数据
    class func getUser(userBlock block: @escaping (_ users: [UserModel])->Void){
        //11行
        
        let count = 10
        var users: [UserModel] = [UserModel]()
        for i in 0..<count {
            let indexStr = String.init(format: "%ld", i)
            let user: UserModel = UserModel.init(i, indexStr, indexStr)
            users.append(user)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            block(users)
        }
    }

}
