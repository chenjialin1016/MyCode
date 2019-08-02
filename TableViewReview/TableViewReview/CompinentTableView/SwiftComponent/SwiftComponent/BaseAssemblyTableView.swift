//
//  BaseAssemblyTableView.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/8/1.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

protocol BaseAssemblyTableViewDelegate {
    func tableViewWillReloadData(_ tableView: BaseAssemblyTableView)
}
extension BaseAssemblyTableViewDelegate{
    func tableViewWillReloadData(_ tableView: BaseAssemblyTableView){
        print(" BaseAssemblyTableViewDelegate tableViewWillReloadData")
    }
}

enum BaseCellMarginType: Int{
    case BaseCellMarginType_Detail
    case BaseCellMarginType_List
}
enum BaseCellLineType: Int{
    case BaseCellLineType_Top
    case BaseCellLineType_Center
    case BaseCellLineType_Bottom
}


class BaseAssemblyTableView: UITableView {

    var baseDelegate : BaseAssemblyTableViewDelegate?
    var cellMarginType : BaseCellMarginType?
    var cellLineType: BaseCellLineType?
    
    internal override func reloadData() {
        if self.baseDelegate == nil {
            self.baseDelegate?.tableViewWillReloadData(self)
        }
        super.reloadData()
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
