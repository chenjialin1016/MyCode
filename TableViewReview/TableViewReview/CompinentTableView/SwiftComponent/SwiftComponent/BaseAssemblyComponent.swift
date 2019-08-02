//
//  BaseAssemblyComponent.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/8/1.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class BaseAssemblyComponent: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK:--------public
    //MARK:--------Register Cell
    public func shouldShowComponent()->Bool{
        return true
    }
    public func registerClass(_ cellClass: AnyClass, forCellReuseIdentifier identifier: String){
        self.tableView?.register(cellClass, forCellReuseIdentifier: identifier)
    }
    public func reloadTableView(){
        self.tableView?.reloadData()
    }
    public func reloadTableViewComponent(){
        self.componentSections?.enumerateObjects({ (obj, idx, stop) in
            let arr = obj as! NSArray
            let isContain = arr.contains(self.componentType as Any)
            if isContain {
                let moduleSet = IndexSet.init(integer: idx)
                self.tableView?.reloadSections(moduleSet, with: UITableView.RowAnimation.none)
                stop[0] = true
            }
        })
    }
    public func reloadTableViewComponentWithRow(_ row: Int){
        self.componentSections?.enumerateObjects({ (obj, idx, stop) in
            let arr = obj as! NSArray
            let isContain = arr.contains(self.componentType as Any)
            if isContain {
                let componentIndexPath = IndexPath.init(row: row, section: idx)
                self.tableView?.reloadRows(at: [componentIndexPath], with: UITableView.RowAnimation.none)
                stop[0] = true
            }
        })
    }
    
    //MARK:--------Life Cycle
    public func setupComponent(){
        print("setupComponent !")
    }
    public func assemblyComponentWillAppear(_ animated: Bool){
        print("assemblyComponentWillAppear !")
    }
    public func assemblyComponentWillDisappear(_ animated: Bool){
        print("assemblyComponentWillDisappear !")
    }
    
    //MARK:--------private
    //MARK:--------TB
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("BaseAssemblyComponent is select: \(indexPath.row)")
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    //MARK:--------no used method
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
