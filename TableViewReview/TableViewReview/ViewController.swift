//
//  ViewController.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/30.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func swiftActionc(_ sender: Any) {
        let vc = SecretViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func swiftMVPAction(_ sender: Any) {
        let vc = MVPViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func OCTBComponentAction(_ sender: Any) {
        
        let vc = MainOCViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func SwiftComponentAction(_ sender: Any) {
//        let vc = MainViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

