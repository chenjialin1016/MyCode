//
//  TableViewDisplay.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/30.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class TableViewRowDisplay{
    let cellHeight : CGFloat
    let autoCellHeight : Bool
    let cellForRowAtIndexPath:((_ tableView: UITableView, _ indexPath:IndexPath)->UITableViewCell)!
    var didSelectRowAtIndexPath:((_ tableView:UITableView, _ indexPath: IndexPath)->Void)?
    
    init(_ cellHeight:CGFloat, _ autoCellHeight:Bool, cellForRowAt indexPath:@escaping (_ tableView:UITableView, _ indexPath:IndexPath)->UITableViewCell) {
        self.autoCellHeight = autoCellHeight
        self.cellHeight = self.autoCellHeight == true ? UITableView.automaticDimension : cellHeight
        self.cellForRowAtIndexPath = indexPath
    }
}

class TableViewSectionDisplay{
    var rows : [TableViewRowDisplay] = []
    let headerHeight : CGFloat!
    let footerHeight : CGFloat!
    let autoHeaderHeight : Bool!
    let autoFooterHeight : Bool!
    public var viewForHeader:((_ tableView:UITableView?, _ section:Int)->UIView)?
    public var viewForFooter:((_ tableView:UITableView?, _ section:Int)->UIView)?
    
    init(_ headerHeight:CGFloat, _ footerHeight:CGFloat, _ autoHeaderHeight:Bool, _ autoFooterHeight:Bool,viewForHeader:((_ tableView:UITableView?, _ section:Int)->UIView)?, viewForFooter:((_ tableView:UITableView?, _ section:Int)->UIView)?, rowaCallback:(_ rows:inout Array<TableViewRowDisplay>)->Void) {
        self.autoHeaderHeight = autoHeaderHeight
        self.autoFooterHeight = autoFooterHeight
        self.headerHeight = self.autoHeaderHeight ? UITableView.automaticDimension : headerHeight
        self.footerHeight = self.autoFooterHeight ? UITableView.automaticDimension : footerHeight
        self.viewForHeader = viewForHeader
        self.viewForFooter = viewForFooter
        rowaCallback(&rows)
    }
}

class TableViewDisplay {
    var sections : Array<TableViewSectionDisplay> = []
    init(sectionCallback:((_ sections: inout Array<TableViewSectionDisplay>)->Void)) {
        sectionCallback(&sections)
    }
}
