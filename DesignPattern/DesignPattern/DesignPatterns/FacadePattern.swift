//
//  FacadePattern.swift
//  DesignPattern
//
//  Created by Jialin Chen on 2019/8/7.
//  Copyright © 2019年 CJL. All rights reserved.
//https://www.cnblogs.com/ludashi/p/5417645.html

import UIKit

//MARK:------”外观模式“ Facade Pattern
/*
 外观模式：提供了一个统一的接口，用来访问子系统中的一群接口，外观定义了一个高层接口，让子系统更容易使用
 简单说：对多个接口进行整合，以简化用户调用的方式
 
 外观模式 对多个对象中的多个方法进行封装
 */

//MARK:------1、无“外观模式” 即 你没有小弟
/*
 1、有3个协议：插排协议SocketType、ComputerType计算机协议、设备显示协议DisplayDeviceType
 2、类：公牛插座OXSocket、MacBookPro、三星显示器SamsungDisplay分别实现了上面的协议
 3、客户端：Client 依赖于三种物品的接口不依赖于具体实现
 */
//插排接口
protocol SocketType2 {
    func on()
    func off()
}
//公牛插排
class OXSocket: SocketType2{
    func on() {
        print("公牛开关已打开")
    }
    
    func off() {
        print("公牛开关已关闭")
    }
}
//笔记本接口
protocol ComputerType {
    func start()
    func shutdown()
}
//MacBookPro
class Macbookpro: ComputerType {
    func start() {
        print("OS X 已启动")
    }
    
    func shutdown() {
        print("OS X 已关闭")
    }
}
//显示器接口
protocol DisplayDeviceType {
    func on()
    func off()
}
//三星显示器
class SamsungDisplay: DisplayDeviceType{
    func on() {
        print("三星显示器已打开")
    }
    
    func off() {
        print("三星显示器已关闭")
    }
}

//MARK:------2、“外观模式” 即 你收了个小弟
//在1的基础上添加了EveryDayWorking类 即 将上面的内容使用外观模式进行简化
class EveryDayWorking{
    private var socket: SocketType2 = OXSocket()
    private var computer: ComputerType = Macbookpro()
    private var display: DisplayDeviceType = SamsungDisplay()
    
    func setSocket(_ socket: SocketType2){
        self.socket = socket
    }
    func setComputer(_ computer: ComputerType){
        self.computer = computer
    }
    func setDisplay(_ display: DisplayDeviceType){
        self.display = display
    }
    
    func startWorking(){
        print("开始工作：")
        socket.on()
        computer.start()
        display.on()
    }
    func endWorking(){
        print("结束工作：")
        display.off()
        computer.shutdown()
        socket.off()
    }
}
