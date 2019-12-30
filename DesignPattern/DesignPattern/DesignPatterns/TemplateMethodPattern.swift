//
//  TemplateMethodPattern.swift
//  DesignPattern
//
//  Created by Jialin Chen on 2019/8/23.
//  Copyright © 2019年 CJL. All rights reserved.
//https://www.cnblogs.com/ludashi/p/5420660.html

import UIKit

//MARK:------”模版方法模式“ Template Method Pattern
/*
 模版方法模式：在一个方法中定义了一个算法的骨架，而将一些步骤延迟到子类中，模版方法使得子类可以在不改变算法结构的情况下，重新定义算法中的某些步骤
 
 模板方法定义了一个算法的步骤，并允许子类为一个或者多个步骤提供实现
 */

//MARK:-----1、炒一个醋溜土豆丝 来一盘清炒黄瓜
class FryShreddedPotatoes{
    func fryShreddedPotatoes(){
        reportTheDisNames()
        putSomeOil()
        putSomeGreenOnion()
        putPotatoes()
        putSaltAndVinegar()
        outOfThePan()
    }
    //报菜名
    func reportTheDisNames(){
        print("醋溜土豆丝：")
    }
    func putSomeOil(){
        print("往锅里放油！")
    }
    func putSomeGreenOnion(){
        print("放葱花爆香！")
    }
    func putPotatoes(){
        print("放土豆丝和青红椒丝!")
    }
    func putSaltAndVinegar(){
        print("放盐和醋！")
    }
    func outOfThePan(){
        print("出锅！\n")
    }
}
class FryBitterGourd{
    func fryBitterGourd(){
        reportTheDisNames()
        putSomeOil()
        putSomeGreenOnion()
        putBitterGourd()
        putSalt()
        outOfThePan()
    }
    //报菜名
    func reportTheDisNames(){
        print("清炒苦瓜：")
    }
    func putSomeOil(){
        print("往锅里放油！")
    }
    func putSomeGreenOnion(){
        print("放葱花爆香！")
    }
    func putBitterGourd(){
        print("放苦瓜和青红椒片!")
    }
    func putSalt(){
        print("放盐！")
    }
    func outOfThePan(){
        print("出锅！\n")
    }
}

//MARK:-----使用模版方法来炒菜
//炒菜的接口
protocol FryVegetablesType {
    func fry()              //模版方法，在延展中给出默认实现
    func reportTheDisNames()//报菜名，在子类中给出实现
    func putSomeOil()       //放油，在延展中给出默认实现
    func putSomeGreenOnion()//放葱花，在延展中给出默认实现
    func putVegetables()    //放蔬菜，在子类中给出具体实现
    func putSpices()        //放调料，在子类中给出具体实现
    func outOfThePan()      //出锅，在延展中给出具体实现
}
//对炒菜接口提供的延展，给出了炒菜中共同的部分和模版方法
extension FryVegetablesType{
    func fry(){
        reportTheDisNames()
        putSomeOil()
        putSomeGreenOnion()
        putVegetables()
        putSpices()
        outOfThePan()
    }
    func putSomeOil(){
        print("往锅里放油！")
    }
    func putSomeGreenOnion(){
        print("放葱花爆香！")
    }
    func outOfThePan(){
        print("出锅！\n")
    }
}
//醋溜土豆丝
class FryShreddedPotatoes2: FryVegetablesType{
    //报菜名
    func reportTheDisNames() {
        print("醋溜土豆丝：")
    }
    
    func putVegetables() {
        print("放土豆和青红椒丝！")
    }
    
    func putSpices() {
        print("放盐和醋！")
    }
}
//清炒苦瓜
class FryBitterGourd2: FryVegetablesType{
    func reportTheDisNames() {
        print("清炒苦瓜：")
    }
    
    func putVegetables() {
        print("放苦瓜片和青红椒片！")
    }
    
    func putSpices() {
        print("放盐！")
    }
}







//MARK:---------测试用例
func test_TemplateMethodPattern(){
    print("==============模版方法模式==============")
    print("============1:无模版方法模式")
    let fryShreddedPotatoes : FryShreddedPotatoes = FryShreddedPotatoes()
    fryShreddedPotatoes.fryShreddedPotatoes()
    let fryBitterGourd : FryBitterGourd = FryBitterGourd()
    fryBitterGourd.fryBitterGourd()
    print("============2:有模版方法模式")
    let fryShreddedPotatoes2 : FryShreddedPotatoes2 = FryShreddedPotatoes2()
    fryShreddedPotatoes2.fry()
    let fryBitterGourd2 : FryBitterGourd2 = FryBitterGourd2()
    fryBitterGourd2.fry()
    print("\n")
}
