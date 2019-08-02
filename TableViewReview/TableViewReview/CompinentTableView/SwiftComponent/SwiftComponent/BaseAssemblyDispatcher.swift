//
//  BaseAssemblyDispatcher.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/8/1.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class BaseAssemblyDispatcher: UIViewController, BaseAssemblyTableViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    var dataDictionary : Dictionary<String, Any>?
    var tableView : BaseAssemblyTableView?
    
    private var assemblyComponents : Dictionary<String, Any>?
    
    //MARK:-----work
    func components()->NSArray{
        return []
    }

    //MARK:-----Private
    private init() {
        super.init(nibName: nil, bundle: nil)
        self.initWithData()
    }
    
    internal override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initWithData()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initWithData(){
        self.assemblyComponents = Dictionary<String, Any>()
    }
    
    internal override func loadView(){
        let rect = UIScreen.main.bounds
        self.view = UIView.init(frame: CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
        self.view.backgroundColor = UIColor.white
        self.view.autoresizingMask = UIView.AutoresizingMask(rawValue: (UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue))
        self.tableView = BaseAssemblyTableView.init(frame: self.view.bounds, style: .plain)
        self.tableView?.delegate = self
        self.tableView?.delegate = self
        self.tableView?.baseDelegate = self
        self.view.addSubview(self.tableView!)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.initWithData()
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for section in (self.assemblyComponents?.values)! {
            (section as! BaseAssemblySectionModel).component?.assemblyComponentWillAppear(animated)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for section in (self.assemblyComponents?.values)! {
            (section as! BaseAssemblySectionModel).component?.assemblyComponentWillDisappear(animated)
        }
    }
    
    //MARK:-----BaseAssemblyTableViewDelegate
    func tableViewWillReloadData(_ tableView: BaseAssemblyTableView) {
        self.updateSections()
    }
    func updateSections(){
        weak var _wself = self
        let list = self.components()
        self.cleanRepeatComponentKey(list)
        list.enumerateObjects { (obj, idx:Int, stop) in
            let arr = obj as! NSArray
            if arr.count < 1 {return}
            let section = BaseAssemblySectionModel()
            section.sectionIndexInTableView = idx
            
            let componentType : String = arr.firstObject as! String
            let componentClass : AnyClass = NSClassFromString(arr[1] as! String)!
            var component : BaseAssemblyComponent? = _wself?.assemblyComponents![String(idx)] as? BaseAssemblyComponent
            if component==nil || (component?.isKind(of: componentClass))!{
                component = self.createComponentWithComponentClass(componentClass, ComponentType: componentType)
            }
            section.component = component
            section.componentKey = componentType
            _wself?.assemblyComponents![String(idx)] = section
        }
    }
    func createComponentWithComponentClass(_ componentClass: AnyClass, ComponentType componentType: String)->BaseAssemblyComponent{
        if componentClass.isSubclass(of: BaseAssemblyComponent.classForCoder()){
            let component : BaseAssemblyComponent = componentClass.init() as! BaseAssemblyComponent
            component.tableView = self.tableView
            component.dataDictionary = self.dataDictionary
            component.componentType = componentType
            component.componentSections = self.components()
            self.addChild(component)
            component.setupComponent()
            
            return component
        }else{
            return BaseAssemblyComponent()
        }
    }
    func cleanRepeatComponentKey(_ list : NSArray){
        weak var _wself = self
        list.enumerateObjects { (obj, idx:Int, stop) in
            let arr = obj as! NSArray
            if arr.count < 1 {return}
            
            let componentType : String = arr.firstObject as! String
            let values : NSArray = NSArray.init(objects: _wself?.assemblyComponents?.values as Any)
            let isRepeate : Int = (_wself?.isRepeat(values, withType: componentType))!
            if isRepeate > -1{
                let section : BaseAssemblySectionModel = self.assemblyComponents![String(idx)] as! BaseAssemblySectionModel
                section.component?.removeFromParent()
                _wself?.assemblyComponents?.removeValue(forKey: String(idx))
            }
        }
    }
    func isRepeat(_ values: NSArray, withType componentType: String)->Int{
        var isRepeate : Int = -1
        values.enumerateObjects { (obj, idx, stop) in
            let section : BaseAssemblySectionModel = obj as! BaseAssemblySectionModel
            if section.componentKey == componentType{
                isRepeate = section.sectionIndexInTableView!
                stop[0] = true
            }
        }
        return isRepeate
    }
    
    //MARK:-----TB
    func numberOfSections(in tableView: UITableView) -> Int {
        let arr = self.assemblyComponents?.keys
        return (arr?.count)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let idx = String(section)
        let sectionComponent : BaseAssemblySectionModel = self.assemblyComponents![idx] as! BaseAssemblySectionModel
        return (sectionComponent.component?.tableView(self.tableView!, numberOfRowsInSection: section))!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idx = String(indexPath.section)
        let sectionComponent : BaseAssemblySectionModel = self.assemblyComponents![idx] as! BaseAssemblySectionModel
//        sectionComponent.component?.view
        return (sectionComponent.component?.tableView(self.tableView!,cellForRowAt:indexPath))!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idx = String(indexPath.section)
        let sectionComponent : BaseAssemblySectionModel = self.assemblyComponents![idx] as! BaseAssemblySectionModel
        sectionComponent.component?.tableView(self.tableView!, didSelectRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let idx = String(section)
        let sectionComponent : BaseAssemblySectionModel = self.assemblyComponents![idx] as! BaseAssemblySectionModel
        return (sectionComponent.component?.tableView(self.tableView!, heightForHeaderInSection:section))!
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let idx = String(section)
        let sectionComponent : BaseAssemblySectionModel = self.assemblyComponents![idx] as! BaseAssemblySectionModel
        return (sectionComponent.component?.tableView(self.tableView!, heightForFooterInSection:section))!
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let idx = String(section)
        let sectionComponent : BaseAssemblySectionModel = self.assemblyComponents![idx] as! BaseAssemblySectionModel
        return (sectionComponent.component?.tableView(self.tableView!, viewForFooterInSection:section))!
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let idx = String(section)
        let sectionComponent : BaseAssemblySectionModel = self.assemblyComponents![idx] as! BaseAssemblySectionModel
        return (sectionComponent.component?.tableView(self.tableView!, viewForFooterInSection:section))!
    }
    
    //MARK:-----no used
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let idx = String(indexPath.section)
        let sectionComponent : BaseAssemblySectionModel = self.assemblyComponents![idx] as! BaseAssemblySectionModel
        (sectionComponent.component?.tableView(self.tableView!, accessoryButtonTappedForRowWith:indexPath))!
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let idx = String(indexPath.section)
        let sectionComponent : BaseAssemblySectionModel = self.assemblyComponents![idx] as! BaseAssemblySectionModel
        return (sectionComponent.component?.tableView(self.tableView!, canEditRowAt:indexPath))!
    }
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        let idx = String(indexPath.section)
        let sectionComponent : BaseAssemblySectionModel = self.assemblyComponents![idx] as! BaseAssemblySectionModel
        return (sectionComponent.component?.tableView(self.tableView!, canFocusRowAt:indexPath))!
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let idx = String(indexPath.section)
        let sectionComponent : BaseAssemblySectionModel = self.assemblyComponents![idx] as! BaseAssemblySectionModel
        return (sectionComponent.component?.tableView(self.tableView!, canMoveRowAt:indexPath))!
    }
}
