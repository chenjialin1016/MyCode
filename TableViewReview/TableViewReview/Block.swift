//
//  Block.swift
//  TableViewReview
//
//  Created by Jialin Chen on 2019/7/31.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

/*
 闭包：是功能性自包含模块，可以在代码中被传递和使用
 
 主要用于callback异步回调，它的本质是一个函数，一个可执行的代码块
 
 闭包的书写格式：
 { (parameters) -> return type in
 statements
 }
 
 */

//简单的闭包
let b =  {
    print("闭包")
}

//带参数和返回值的闭包
let countNum = {(num1: Int, num2: Int)->Int in
    return num1+num2
}
let count1 = countNum(2, 3)



//swift内联提供了参数名称缩写功能
var names = ["s", "b", "e", "h", "f"]
var reversedNames = names.sort { (s1, s2) -> Bool in
    return s1 > s2
}
var reversedNames1 = names.sort(by: {s1, s2 in return s1 > s2})
var reversedNames2 = names.sort(by: {s1, s2 in s1 > s2})
var reversedNames3 = names.sort(by: {$0 > $1})
//返回布尔值可以直接给一个判断符号
var reversedNames4 = names.sort(by: >)

//尾部闭包
var reversedNames5 = names.sorted(){$0 > $1}
//无其他参数的情况
var reversedNames6 = names.sorted {$0 > $1 }


//关键字typealias先声明一个闭包的数据类型
typealias AddBlock = (Int, Int)->Int
let add : AddBlock = {(a, b) in
    return a+b
}
var result = add(100, 200)


//逃逸闭包：一般用于异步函数的回调，比如网络请求
//语法：在函数的闭包行参前加关键字@escaping
func requestData2(_ urlString: String, succeed: @escaping (Any?, Any?)->(Void), failure: @escaping (Any?, Any?)->(Void)){
    let request = URLRequest(url: URL(string: urlString)!)
    //发送网络请求
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if error == nil{
            //请求成功，执行成功回调
            succeed(data, response)
        }else{
            //请求失败，执行失败回调
            failure(error, response)
        }
    }
}


//闭包的应用场景：异步执行回调、控制器之间的回调、自定义视图的回调
//异步回调--网络请求为例。succeed、failure是尾随闭包
func requestData(_ urlString: String, succeed: ((Any?, Any?)->(Void))?, failure:((Any?, Any?)->(Void))?){
    let request = URLRequest(url: URL(string: urlString)!)
    //发送网络请求
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if error == nil{
            //请求成功，执行成功回调
            succeed?(data, response)
        }else{
            //请求失败，执行失败回调
            failure?(error, response)
        }
    }
}
class Newtwork{
    init() {
        requestData("http://www.baidu.com", succeed: { (data, response) -> (Void) in
            print("成功的回调")
        }) { (data, response) -> (Void) in
            print("失败的回调")
        }
        
        requestData2("http://www.baidu.com", succeed: { (data, response) -> (Void) in
            print("成功的回调")
        }) { (error, response) -> (Void) in
            print("失败的回调")
        }
    }
}

//自定义视图的回调
class CustomView: UIView{
    var btnClickBlock:(()->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //创建按钮，绑定事件
        let btn = UIButton(frame: CGRect.init(x: 15, y: 15, width: 80, height: 32))
        btn.setTitle("按钮", for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.addTarget(self, action: Selector(("btnClick")), for: .touchUpInside)
        addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnClick(){
        if btnClickBlock != nil {
            //注意：属性btnClickBlock是可选类型，需要先解包
            btnClickBlock!()
        }
    }
}
class ViewController1: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建自定义视图
        let customeView = CustomView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
        customeView.btnClickBlock = {
            print("按钮被点击")
        }
        customeView.backgroundColor = UIColor.yellow
        self.view.addSubview(customeView)
    }
}


//block中循环引用的解决方式
func loadData(completion: @escaping (_ result: [String])->())->(){
    DispatchQueue.global().async {
        print("耗时操作")
        let json = ["1", "2"]
        
        DispatchQueue.main.async {
            print(" 主线程更新")
            completion(json)
        }
    }
}

func loadData2(completion: @escaping ()->())->(){
    DispatchQueue.global().async {
        print("耗时操作")
        
        DispatchQueue.main.async {
            print(" 主线程更新")
        }
    }
}

class UserView : UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func load(){
        loadData { (json) in
            print(json)
        }
        
        //第一种 套用oc的方式（__weak typedef(weakself)=self）
        //里要注意，不能用  let  ，因为self可能会释放指向nil，相当于是一个可变值
        weak var weakSelf = self
        
        //第二种
        //在调用时，标识为弱引用, [weak self]标识在{}中所有的self都是弱引用
        loadData2{ [weak self] in
            print(self!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

