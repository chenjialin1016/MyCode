//
//  ViewController.swift
//  RACStudy
//
//  Created by Jialin Chen on 2019/8/20.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa

class ViewController: UIViewController {
    
    var student: SMStudent!
    lazy var testButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("增加5个积分", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        self.view.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.center.equalTo(self.view)
        })
        return button
    }()
    var currentCreditLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.lightGray
        return label
    }()
    var isSatisfyLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .right
        label.textColor = UIColor.lightGray
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupUI()
        //present
        self.student = SMStudent.create().name("ming").gender(.SMStudentGenderMale).studentNumber(345).filterIsASatisfyCredit({ (credit) -> Bool in
            
            if credit >= 70{
                self.isSatisfyLabel.text = "合格"
                self.isSatisfyLabel.textColor = UIColor.red
                return true
            }else{
                self.isSatisfyLabel.text = "不合格"
                return false
            }
        })
        
        self.testButton.rac_signal(for: .touchUpInside)?.subscribeNext({ (x) in
            self.student = self.student.sendCredit(updateCreditBlock: { ( credit) -> Int in
                credit = credit + 5
                print("current credit \(credit)")
                self.student.creditSubject = self.student.creditSubject.sendNext(credit)
                return credit
            })
        })
        
        self.student.creditSubject.subscriptNext { (credit) in
            print("第一个订阅的credit处理积分 \(credit)")
            self.currentCreditLabel.text = String(credit)
            if credit < 30 {
                self.currentCreditLabel.textColor = UIColor.lightGray
            }else if credit < 70 {
                self.currentCreditLabel.textColor = UIColor.purple
            }else{
                self.currentCreditLabel.textColor = UIColor.red
            }
        }
        
        self.student.creditSubject.subscriptNext { (credit) in
            print("第二个订阅的credit处理积分 \(credit)")
            if !(credit > 0){
                self.currentCreditLabel.text = "0"
                self.isSatisfyLabel.text = "未设置"
            }
        }
    }

    /*
     函数式响应编程
     
     功能：添加学生基本信息，添加完学生信息后，通过按钮点击累加学生分数，每次点击按钮分数加5；所得分数在30分以内，颜色显示为灰色；分数在30到70分之间，颜色显示为紫色；分数在70分以内，状态文本显示不合格；超过70分，分数颜色显示为红色，状态文本显示合格。初始态分数为0，状态文本显示未设置。
     
     */
    

    func setupUI(){
        
        self.view.addSubview(self.currentCreditLabel)
        self.currentCreditLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(40)
            make.left.equalTo(self.view).offset(40)
        }
        
        self.view.addSubview(self.isSatisfyLabel)
        self.isSatisfyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
        }
    }
}

