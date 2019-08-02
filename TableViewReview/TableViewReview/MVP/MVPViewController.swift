//
//  MVPViewController.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/31.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class MVPViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        let modelPresent = UserModelPresent.init()
        modelPresent.delegate = self
//        modelPresent.getUsers()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MVPViewController: UserViewDelegate{
    func setUsers(_ users: [UserModel]) {
        print("接收数据")
    }
}
