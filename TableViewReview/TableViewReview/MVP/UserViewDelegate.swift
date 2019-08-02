//
//  UserViewDelegate.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/31.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

protocol UserViewDelegate {
     func startLoading()
     func finishLoading()
     func setEmptyUsers()
    
     func setUsers(_ users: [UserModel])
    
}

extension UserViewDelegate{
    func startLoading(){
        print("开始操作")
    }
    func finishLoading(){
        print("结束操作")
    }
    func setEmptyUsers(){
        print("数据为空")
    }
}


protocol OptionalProtocol{
    //可选方法
    func  optionalMethod()
    //必选
    func necessaryMethod()
}
extension OptionalProtocol{
    func  optionalMethod(){
        print("Implemented in extension")
    }
}

class Test:OptionalProtocol{
    func necessaryMethod() {
        
    }
    
}
