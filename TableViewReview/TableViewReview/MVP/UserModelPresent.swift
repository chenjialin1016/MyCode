//
//  UserModelPresent.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/31.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class UserModelPresent: NSObject {

    var delegate : UserViewDelegate?
    
    func getUsers(){
        UserModel.getUser { (users) in
            self.delegate?.finishLoading()
            
            let isUsers = (users.count != 0)
            if isUsers{
                self.delegate?.setEmptyUsers()
            }else{
                self.delegate?.setUsers(users)
            }
        }
    }
}
