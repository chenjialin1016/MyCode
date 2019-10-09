//
//  SMStudent.swift
//  RACStudy
//
//  Created by Jialin Chen on 2019/8/20.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

enum SMStudentGender: Int{
    case SMStudentGenderMale
    case SMStudentGenderFemale
}

typealias SatisfyActionBlock = (_ credit: Int)->Bool

class SMStudent: NSObject {
    lazy var creditSubject: SMCreditSubject = {
        let credit = SMCreditSubject.create()
        return credit
    }()
    var isSatisfyCredit: Bool = false
    
    private var name: String!
    private var gender: SMStudentGender!
    private var number: Int = 0
    private var credit: Int = 0
    private var satisfyBlock: SatisfyActionBlock?
    
    class func create()->SMStudent{
        let student = SMStudent.init()
        return student
    }
    func name(_ name: String)->SMStudent{
        self.name = name
        return self
    }
    func gender(_ gender: SMStudentGender)->SMStudent{
        self.gender = gender
        return self
    }
    func studentNumber(_ number: Int)->SMStudent{
        self.number = number
        return self
    }
    
    //积分相关
    func sendCredit(updateCreditBlock: ((_ credit: inout Int)->Int)?)->SMStudent{
        if updateCreditBlock != nil  {
            self.credit = updateCreditBlock!(&self.credit)
            if self.satisfyBlock != nil{
                self.isSatisfyCredit = self.satisfyBlock!(self.credit)
                if isSatisfyCredit {
                    print("true")
                }else{
                    print("false")
                }
            }
        }
        return self
    }
    func filterIsASatisfyCredit(_ satisfyBlock: SatisfyActionBlock?)->SMStudent{
        if satisfyBlock != nil {
            self.satisfyBlock = satisfyBlock
            self.isSatisfyCredit = self.satisfyBlock!(self.credit)
        }
        return self
    }
}
