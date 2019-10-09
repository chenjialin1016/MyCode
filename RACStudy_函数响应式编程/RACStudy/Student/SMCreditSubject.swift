//
//  SMCreditSubject.swift
//  RACStudy
//
//  Created by Jialin Chen on 2019/8/20.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class SMCreditSubject: NSObject {
    
    typealias SubscribeNextActionBlock = (_ credit: Int)->Void
    
    private var credit: Int = 0
    private var subscribeNextBlock: SubscribeNextActionBlock!
    private lazy var blockArray: [SubscribeNextActionBlock] = {
        let blockArr = [SubscribeNextActionBlock]()
        return blockArr
    }()
    
    override init() {
        super.init()
    }
    
    class func create()->SMCreditSubject{
        let subject: SMCreditSubject = SMCreditSubject.init()
        return subject
    }
    
    func sendNext(_ credit: Int)->SMCreditSubject{
        self.credit = credit
        if self.blockArray.count > 0 {
            for block in self.blockArray{
                block(self.credit)
            }
        }
        return self
    }
    
    func subscriptNext(_ block: SubscribeNextActionBlock?)->SMCreditSubject{
        if block != nil{
            block!(self.credit)
        }
        self.blockArray.append(block!)
        return self
    }

}
