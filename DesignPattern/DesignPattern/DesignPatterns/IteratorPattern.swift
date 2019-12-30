//
//  IteratorPattern.swift
//  DesignPattern
//
//  Created by 陈嘉琳 on 2019/10/23.
//  Copyright © 2019年 CJL. All rights reserved.
//https://www.cnblogs.com/ludashi/p/5434489.html

import UIKit

//MARK:------”迭代器模式“  Iterator Pattern
/*
 迭代器模式：提供一种方法顺序访问一个聚合对象中的每个元素，又不暴露其内部的表示
 
 swift应用：利用迭代器遍历字典和数组
 
 */

//场景：数组和字典使用迭代器进行遍历

//MARK:------1、无“迭代器”的电影院
//电影院接口
protocol CinemaType01 {
    func display()
}

//实现接口的电影院
class Cinema01: CinemaType01{
    private let items = ["美人鱼", "夏洛特烦恼", "末日崩塌"]
    func display() {
        print("\n第一电影院：")
        for i in 0..<items.count {
            print(items[i])
        }
    }
}

class Cinema02: CinemaType01{
    private let items : Dictionary<String, String> = ["001":"老炮儿", "002":"疯狂动物城", "003":"泰囧"]
    func display() {
        print("\n第二电影院：")
        let allkeys = Array(items.keys)
        for i in 0..<allkeys.count {
            guard let item = items[allkeys[i]] else{
                continue
            }
            print(item)
        }
    }
}

//商场类
class Market{
    private var cinemas: Array<CinemaType01> = Array<CinemaType01>()
    func addCinema(_ cinema: CinemaType01){
        self.cinemas.append(cinema)
    }
    
    func display(){
        for i in 0..<cinemas.count {
            let cinema = cinemas[i]
            cinema.display()
        }
    }
}



//MARK:------2、使用“迭代器”来规范商场中的影院
//只要使用迭代器遍历，其遍历方式是不变的
//将display方法重命名 iteratorItem

//======迭代器
//迭代器接口：Iterator
/*
 hasNext()，用来判断是否有下一项。
 next()方法，如果有下一项，那么就使用next()方法来获取下一项
 */
protocol Iterator {
    func hasNext()->Bool
    func next()->AnyObject?
}

//数组、字典迭代器
class ArrayIterator: Iterator{
    private let items: Array<AnyObject>
    private var position: Int = 0
    
    init(_ items: Array<AnyObject>) {
        self.items = items
    }
    
    func hasNext() -> Bool {
        return position < items.count
    }
    
    func next() -> AnyObject? {
        let item = items[position]
        position += 1
        return item
    }
}
class DictionaryIterator: Iterator{
    private let items: Dictionary<String, AnyObject>
    private var position: Int = 0
    private var allKeys: [String]{
        get{
            return Array(items.keys)
        }
    }
    
    init(_ items: Dictionary<String, AnyObject>) {
        self.items = items
    }
    
    func hasNext() -> Bool {
        return position < items.count
    }
    
    func next() -> AnyObject? {
        let item = items[allKeys[position]]
        position += 1
        return item
    }
}


//=====工厂模式重构电影院
//影院协议 CinemaType
/*
 iteratorItem()方法就是我们上一部分的display()方法
 createIterator()方法就是我们的工厂方法，它负责创建相应的迭代器
 */
protocol CinemaType {
    func createIterator()->Iterator
    func iteratorItem()
}
//电影院协议的默认延展 extension CinemaType
extension CinemaType{
    func iteratorItem(){
        let iterator = createIterator()
        while iterator.hasNext() {
            guard let item = iterator.next() else{
                continue
            }
            print(item)
        }
    }
}

//电影院的具体实现
class Cinema03: CinemaType{
    let items = ["美人鱼", "夏洛特烦恼", "末日崩塌"]
    func createIterator() -> Iterator {
        return ArrayIterator(items as Array<AnyObject>)
    }
}

class Cinema04: CinemaType{
    let items = ["001":"老炮儿", "002":"疯狂动物城", "003":"泰囧"]
    func createIterator() -> Iterator {
        return DictionaryIterator(items as Dictionary<String, AnyObject>)
    }
}

//Market类
class Market2{
    private var cinemas: Array<CinemaType> = Array<CinemaType>()
    func addCinema(_ cinema: CinemaType){
        self.cinemas.append(cinema)
    }
    
    func display(){
        for i in 0..<cinemas.count {
            cinemas[i].iteratorItem()
        }
    }
}







//MARK:---------测试用例
func test_IteratorPattern(){
    print("==============迭代器模式==============")
    print("============1:无“迭代器”的电影院")
    let market = Market()
    market.addCinema(Cinema01())
    market.addCinema(Cinema02())
    market.display()
    print("============2:使用“迭代器”来规范商场中的影院")
    let market2 = Market2()
    market2.addCinema(Cinema03())
    market2.addCinema(Cinema04())
    market2.display()
    print("\n")
}
