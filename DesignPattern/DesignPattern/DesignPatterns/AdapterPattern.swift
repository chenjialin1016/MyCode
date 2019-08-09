//
//  AdapterPattern.swift
//  DesignPattern
//
//  Created by Jialin Chen on 2019/8/6.
//  Copyright © 2019年 CJL. All rights reserved.
//https://www.cnblogs.com/ludashi/p/5408991.html

import UIKit

//MARK:------”适配器模式“ Adapter Pattern
/*
 适配器模式：将一个类的接口，转换成客户期望的另一个接口，适配器让原本接口不兼容的类可以合作无间
 
 适配器的职责 就是将一种接口转换成另一种接口
 */

//实现 插座、适配器 以及 macbook pro 和其自带电池间的关系

/*
 类图中的红色部分：模拟插座
 
 该模块含有一个SocketType协议，该协议是socket的一种规范，暂且理解为国标，其中定义了插座的统一规范，只给出了声明没有实现，要实现的socket都遵循于sockettype协议，即 中国成产的插座要符合中国国标，美国生产的插座要符合美国国标
 */
//家用插座协议
protocol SocketType {
    func socketOutputVoltage() -> Float
}
//家用插座输出电力为 220v
class Socket: SocketType{
    func socketOutputVoltage() -> Float {
        return 220.0
    }
}


/*
 类图中的绿色部分：mackbook pro
 
 其中也有个协议，名为ComputerPowerSourceType。该协议是笔记本电脑💻的供电系统协议，只要是遵循该协议（接口）的电源都可以给MacBook Pro供电。从类图可以看出，MacBook Pro是依赖于供电系统的协议的而不是依赖于具体实现，所以笔记本电脑的自带电池是可以进行更换的，而且可以外接电源。但是外接电源也得必须要遵循MacBook Pro中的ComputerPowerSourceType协议。
 */
//计算机电源接口
protocol ComputerPowerSourceType {
    func outputVoltage() -> Float
}
//macbook pro 的电池（自带电源）
class MacBookProBattery: ComputerPowerSourceType{
    func outputVoltage() -> Float {
        return 16.5
    }
}
//macbook pro
class MacBookPro{
    //电源
    private var powerSource: ComputerPowerSourceType? = nil
    //连接电源
    func connectPowerSource(_ powerSource: ComputerPowerSourceType){
        self.powerSource = powerSource
    }
    //电源输入电压
    func inputVoltage(){
        if powerSource != nil {
            print("输入电压：\(self.powerSource?.outputVoltage())")
        }
    }
}

/*
 类图中的黄色部分：适配器
 
 黄框中一个类是一个适配器，也就是黄框中是两个适配器。不过这两个适配器实现方式不同，也就是不同类型的适配器，但都可以连接插座给MacBookPro进行供电。两者的具体不同之处会在具体实现的时候给出详细的解释。无论使用哪个电源适配器，我们的MacBook Pro就可以接上插座来工作了。这两个适配器因为一方要连接MacBookPro，所以都实现了ComputerPowerSourceType协议，这样适配器的一端连接MacBook Pro就不成问题了。除了连接MacBook Pro外，你还得对插座输出的电压等进行处理，从而MacBook Pro可以使用处理后的电压电流等。因为初始电流是插座提供的，所以适配器为了处理电压和电流还需要还需要继承或者依赖于插座。依赖插座的适配器我们称之为“对象适配器”（插座是适配器中的一个对象），继承自插座的适配器我们称之为“类适配器”（插座是适配器中的父类）
 
 对象适配器 依赖于接口，类适配器 依赖于具体实现
 */
//对象适配器的实现
/*
 对象适配器 依赖于插座的接口而不依赖于插座的具体实现
 */
//对象适配器：包含某个插座类型
class MacPowerObjectAdapter: ComputerPowerSourceType{
    
    //电源接口对象
    var socketPower: SocketType? = nil
    
    //适配器的一段插入插座
    func insertSocket(_ socketPower: SocketType){
        self.socketPower = socketPower
    }
    
    //电流通过适配器后进行输出，输出规则要遵循 ComputerPowerSourceType协议
    func outputVoltage() -> Float {
        //通过各种电路将电压进行转换
        guard let voltage = socketPower?.socketOutputVoltage() else{
            return 0
        }
        if voltage > 16.5 {
            return 16.5
        }else{
            return 0
        }
    }
}
//类适配器的实现
/*
 类适配器 依赖于socket类的具体实现（是继承在某个特定的插座的类）
 */
//类适配器：继承自某个特定插座并实现计算机电源协议
class MacPowerClassAdapter: Socket, ComputerPowerSourceType{
    func outputVoltage() -> Float {
        if self.socketOutputVoltage() > 16.5 {
            return 16.5
        }else{
            return 0
        }
    }
}

//MARK:-----------示例2:Demo
protocol AType {
    func functionA()
}
class A: AType {
    func functionA() {
        print("我是AAA")
    }
}
protocol BType {
    func functionB()
}
class B: BType {
    func functionB() {
        print("我是BBB")
    }
}
//对象适配器
class AdapterA: BType {
    var a: AType
    init(_ a: AType) {
        self.a = a
    }
    func functionB() {
        a.functionA()
    }
}
//类适配器
class AdapterAA: A, BType {
    func functionB() {
        self.functionA()
    }
}

//MARK:-----------示例3:火鸡适配器
//鸭子
protocol Duck2 {
    func quack()
    func fly()
}
class  MallardDuck2: Duck2 {
    func quack() {
        print("quack")
    }
    
    func fly() {
        print("I'm flying")
    }
}
//街头顽禽
protocol Turkey {
    func gobble()
    func fly()
}
class wildTurkey: Turkey{
    func gobble() {
        print("gobble gobble")
    }
    
    func fly() {
        print("I'm flying a short distance")
    }
}
//需求：你缺鸭子，需要用火鸡来冒充
//写一个火鸡适配器
class TurkeyAdapter: Duck2{
    
    var turkey: Turkey
    init(_ turkey: Turkey) {
        self.turkey = turkey
    }
    
    func quack() {
        turkey.gobble()
    }
    
    func fly() {
        for _ in 0..<5 {
            turkey.fly()
        }        
    }
}
