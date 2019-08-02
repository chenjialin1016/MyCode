//
//  SecretViewController.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/30.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class SecretViewController: UIViewController {
    
    var tableView: UITableView!
    var secret: TableViewSecret!
    var newsModel: NewsModel?
    var personModel: PersonModel?
    var appliancesModel: AppliancesModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "swift版 tableView的delegate、datasource封装"
        
        configUI()
        
        configData()
        
        display()
    }
    

    func configUI(){
        self.tableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        self.view.addSubview(tableView)
    }
    func configData(){
        let dicNews = Util.getJsonData(from: "NewsList", "json")
        let dicPerson = Util.getJsonData(from: "Person", "json")
        let dicAppliances = Util.getJsonData(from: "Appliances", "json")
        newsModel = NewsModel.deserialize(from: dicNews)
        personModel = PersonModel.deserialize(from: dicPerson)
        appliancesModel = AppliancesModel.deserialize(from: dicAppliances)
    }

    func display(){
        let display = TableViewDisplay { (sections) in
            //1、news
            sections.append(TableViewSectionDisplay(45, 50, false, false, viewForHeader: { (tableView, section) -> UIView in
                let header = tableView?.headerFooter(nib: NewsListTableHeaderView.self) as! NewsListTableHeaderView
                header.lblName.text = "新闻列表"
                return header
            }, viewForFooter: { (tableView, section) -> UIView in
                let footer = tableView?.headerFooter(nib: NewsListTableFooterView.self) as! NewsListTableFooterView
                footer.lblDesc.text = "新闻列表"
                return footer
            }, rowaCallback: { (rows) in
                for (_, value) in (newsModel?.newslist!.enumerated())! {
                    let row = TableViewRowDisplay(60, true, cellForRowAt: { (tableView, indexPath) -> UITableViewCell in
                        let cell = tableView.cell(nib: NewsListTableViewCell.self) as! NewsListTableViewCell
                        cell.lblTitle.text = value.title
                        cell.lblSubTitle.text = value.source
                        return cell
                    })
                    rows.append(row)
                }
            }))
            
            //2、appliances
            sections.append(TableViewSectionDisplay(90, CGFloat.leastNormalMagnitude, false, false, viewForHeader: { (tableView, section) -> UIView in
                let header = tableView?.headerFooter(nib: AppliancesTableHeaderView.self) as! AppliancesTableHeaderView
                header.lblName.text = "这里的电器"
                return header
            }, viewForFooter: nil, rowaCallback: { (rows) in
                rows.append(TableViewRowDisplay(100.0, false, cellForRowAt: { (tableView, indexPath) -> UITableViewCell in
                    let cell = tableView.cell(nib: AppliancesTableViewCell.self) as! AppliancesTableViewCell
                    cell.lblName.text = self.appliancesModel?.name
                    cell.lblColor.text = self.appliancesModel?.color
                    cell.lblPrice.text = "\(self.appliancesModel?.price)"
                    return cell
                }))
            }))
            
            //3、animal & person
            sections.append(TableViewSectionDisplay(50, CGFloat.leastNormalMagnitude, false, false, viewForHeader: nil, viewForFooter: nil, rowaCallback: { (rows) in
                rows.append(TableViewRowDisplay(self.tableView.bounds.size.width/16.0*9.0, false, cellForRowAt: { (tableView, indexPath) -> UITableViewCell in
                    let cell = tableView.cell(nib: AnimalTCell.self) as! AnimalTCell
                    return cell
                }))
                rows.append(TableViewRowDisplay(80.0, false, cellForRowAt: { (tableView, indexPath) -> UITableViewCell in
                    let cell = tableView.cell(any: PersonTCell.self) as! PersonTCell
                    cell.lblName.text = "张三"
                    return cell
                }))
            }))
        }
        self.secret = TableViewSecret(tableView, display)
        self.secret.didSelectRowAtIndexPath = {(tableView, indexPath) in
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
