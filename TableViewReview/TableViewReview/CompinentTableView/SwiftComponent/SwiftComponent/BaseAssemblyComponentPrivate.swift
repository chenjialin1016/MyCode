//
//  BaseAssemblyComponentPrivate.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/8/1.
//  Copyright © 2019年 CJL. All rights reserved.
//

import Foundation
import UIKit

struct AssociateKey {
    static let keyForTableView = "keyForTableView"
    static let keyForDataDicitionary = "keyForDataDicitionary"
    static let keyForComponentSection = "keyForComponentSection"
    static let keyForComponentType = "keyForComponentType"
    
}

extension BaseAssemblyComponent{
    var dataDictionary : Dictionary<String, Any>?{
        set{
            if let newValue = newValue {
                objc_setAssociatedObject(self, AssociateKey.keyForDataDicitionary, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
        get{
            return objc_getAssociatedObject(self, AssociateKey.keyForDataDicitionary) as? Dictionary<String, Any>
        }
    }
    var tableView : BaseAssemblyTableView?{
        set{
            if let newValue = newValue {
                objc_setAssociatedObject(self, AssociateKey.keyForTableView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
        get{
            return objc_getAssociatedObject(self, AssociateKey.keyForTableView) as? BaseAssemblyTableView
        }
    }
    var componentType: String?{
        set{
            if let newValue = newValue {
                objc_setAssociatedObject(self, AssociateKey.keyForComponentType, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
        get{
            return objc_getAssociatedObject(self, AssociateKey.keyForComponentType) as? String
        }
    }
    var componentSections : NSArray?{
        set{
            if let newValue = newValue {
                objc_setAssociatedObject(self, AssociateKey.keyForComponentSection, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
        get{
            return objc_getAssociatedObject(self, AssociateKey.keyForComponentSection) as? NSArray
        }
    }
    
    
    
    
}
