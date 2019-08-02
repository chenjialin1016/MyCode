//
//  TitleTableViewCell.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/8/1.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell, BaseCellProtocol {

    var textlbl : UILabel?
    
    func updateData(_ model: AnyObject) {
        self.initSubViews()
        
        if (model.classForCoder?.isSubclass(of: NSString.classForCoder()))!{
            self.textlbl?.text = model as? String
        }
    }
    
    func initSubViews(){
        if textlbl == nil {
            self.textlbl = UILabel.init()
            self.textlbl?.textColor = UIColor.black
            self.textlbl?.font = UIFont.systemFont(ofSize: 18.0)
            self.contentView.addSubview(self.textlbl!)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textlbl?.frame = CGRect(x: 15, y: 0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
    }

    
}
