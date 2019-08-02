//
//  Util.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/30.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

class Util {
    static func loadXib(_ name: String)->Any?{
        let view = Bundle.main.loadNibNamed(name, owner: self, options: nil)
        return view
    }
    
    static func getJsonData(from jsonPath: String, _ fileType: String)->Dictionary<String, AnyObject>?{
        let path = Bundle.main.path(forResource: jsonPath, ofType: fileType)
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let jsonDic = jsonData as! Dictionary<String, AnyObject>
            return jsonDic
        }catch let error as Error?{
            print("local json reading error: ", error)
        }
        return nil
    }
}
