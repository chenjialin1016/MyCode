//
//  ViewController.swift
//  SampleApp
//
//  Created by Jialin Chen on 2019/7/18.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tableView : UITableView = UITableView.init(frame: self.view.bounds)
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }


}


extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "id")
        cell.textLabel?.text = "主标题"
        cell.detailTextLabel?.text = "副标题"
        cell.imageView?.image = UIImage.init(named: "icon.bundle/page@2x.png")
        return cell
    }
    
    
}
