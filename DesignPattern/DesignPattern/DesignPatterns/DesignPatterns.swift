//
//  DesignPatterns.swift
//  test
//
//  Created by Jialin Chen on 2019/7/1.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//https://www.cnblogs.com/ludashi/p/5395849.html

import UIKit

func designPatternsTest(){
    print("==============策略模式==============")
    //中尉
    let lieutenant : Lieutenant = Lieutenant()
    lieutenant.fire()
    print("\n手枪火力不行，得换HK48\n")
    lieutenant.changeHK()
    lieutenant.fire()
    
    print("\n-----某些鸭子增加飞行的能力")
//    print("鸭子：使用延展")
//    let mallarDuck : MallarDuck = MallarDuck()
//    mallarDuck.fly()
    
    print("鸭子：使用接口")
    var duck : Duck = MallarDuck()
    duck.performFly()
    duck.setFlyBehavior(FlyNoWay())
    duck.performFly()
    print("-----创建一个模型鸭子，且会飞")
    duck = ModelDuck()
    duck.performFly()
    print("-----给模型鸭子装发动机，支持飞")
    duck.setFlyBehavior(FlyAutomaticPower())
    duck.performFly()
    print("\n")
    
    print("==============观察者模式==============")
    //创建boss
    let bossSubject : Boss = Boss()
    //创建观察者
    let coderObserver : Coder = Coder()
    let PMObserver : PM = PM()
    //添加观察者
    bossSubject.registerObserver(coderObserver)
    bossSubject.registerObserver(PMObserver)
    print(bossSubject.observersArray)
    bossSubject.setInfo("第一次通知")
    //程序员走出了会议室（移除通知）
    bossSubject.removeObserver(coderObserver)
    bossSubject.setInfo("第二次通知")
    print("------Foundation自带的通知模式")
    let boss1 = Boss1()
    let coder1 = Coder1()
    coder1.observerBoss()
    boss1.sendMessage("涨工资啦")
    print("------自定义的通知中心")
    let boss2 = Boss2()
    let coder2 = Coder2()
    let coder3 = Coder2()
    coder2.observerBoss()
    coder3.observerBoss()
    boss2.sendMessage("涨工资啦")
    print("------气象观测")
    let weatherData : WeatherData = WeatherData()
    let currentConditions = CurrentConditionsDisplay(weatherData)
    weatherData.setMeasurements(20, 34, 40)
    print("\n")
    
    
    print("==============装饰者模式==============")
    print("------示例1")
    //创建空花瓶
    var porcelain : VaseComponent = Porcelain()
    //打印最新的描述信息
    porcelain.display()
    //插入玫瑰
    porcelain = Rose(porcelain)
    //插入百合
    porcelain = Lily(porcelain)
    //打印最新的描述信息
    porcelain.display()
    print("------示例2")
    //创建浓缩咖啡
    var espresso : Beverage = Espresso()
    //用户点了一杯牛奶摩卡浓缩咖啡
    espresso = Milk(espresso)
    espresso = Mocha(espresso)
    print(espresso.getDescription())
    print(espresso.cost())
    print("\n")
    
    print("==============工厂模式==============")
    print("------示例1：无工厂模式")
    let weaponUser : WeaponUser = WeaponUser()
    weaponUser.fireWithType(.AK)
    weaponUser.fireWithType(.AWP)
    print("------示例2：简单工厂模式")
    let weaponUser2 : WeaponUser2 = WeaponUser2.init(WeaponFactory())
    weaponUser.fireWithType(.AK)
    weaponUser.fireWithType(.AWP)
    print("------示例3：工厂方法模式")
    var user : WeaponUser3 = GermanyWeaponUser()
    user.fireWithType(.AK)
    user = AmericaWeaponUser()
    user.fireWithType(.AK)
    print("------示例4：抽象工厂模式")
    var user4 : WeaponUser4 = WeaponUser4.init(AmericanWeaponFactory())
    user4.fireWithType(.AK)
    user4.fireWithType(.HK)
    user4.fireWithType(.AWP)
    user4.setFactory(GermangWeaponFactory())
    user4.fireWithType(.AK)
    user4.fireWithType(.HK)
    user4.fireWithType(.AWP)
    print("------示例5：抽象工厂模式+工厂模式")
    var user5 : WeaponUserType = AmericanWeaponUser5()
    user5.fireWithType(.AK)
    user5.fireWithType(.HK)
    user5.fireWithType(.AWP)
    user5 = GermanyWeaponUser5()
    user5.fireWithType(.AK)
    user5.fireWithType(.HK)
    user5.fireWithType(.AWP)
    print("------披萨：无工厂")
    var pizza : PizzaStore = PizzaStore()
    pizza.orderPizza(.Cheese)
    pizza.orderPizza(.Greek)
    print("------披萨：简单工厂")
    var pizza2 : PizzaStore2 = PizzaStore2.init(SimplePizzaFactory())
    pizza2.orderPizza(.Cheese)
    pizza2.orderPizza(.Pepperoni)
    print("------披萨：工厂方法")
    var pizza3 : PizzaStore3 = NYStylePizzaStore()
    pizza3.orderPizza(.Cheese)
    pizza3 = ZJGStylePizzaStore()
    pizza3.orderPizza(.Clam)
    print("------披萨：抽象工厂方法")
    var pizza4 : PizzaStore4 = PizzaStore4.init(NYPizzaIngredientFactory())
    pizza4.orderPizza(.Cheese)
    pizza4.setFactory(ZJGPizzaIngredientFactory())
    pizza4.orderPizza(.Pepperoni)
    print("\n")
    
    
    print("==============单例模式==============")
    print("------GCD实现单例")
    let singleton1 = SingletonManager.sharedInstance()
    let singleton2 = SingletonManager.sharedInstance()
    printAdress(singleton1 as AnyObject, singleton2 as AnyObject)
    print("------静态实现单例")
    let singleton3 = SingletonManager1.sharedInstance()
    let singleton4 = SingletonManager1.sharedInstance()
    printAdress(singleton3 as AnyObject, singleton4 as AnyObject)
    print("\n")
    
    
    print("==============命令模式==============")
    var console : Console = Console()
    console.setCommand(LightOnCommand())
    console.action()
    console.setCommand(LightOffCommand())
    console.action()
    console.setCommand(ComputerStartCommand())
    console.action()
    print("\n")
    
    
    print("==============适配器模式==============")
    //创建笔记本对象
    let macBookPro : MacBookPro = MacBookPro()
    //创建macbookpro所用电池的对象
    let macBookProBattery = MacBookProBattery()
    //创建电源对象
    let socket :SocketType = Socket()
    //创建适配器“对象适配器”的对象
    let macBookProObjectAdapter = MacPowerObjectAdapter()
    //创建“类适配器”对象
    let macBookProClassAdapter = MacPowerClassAdapter()
    print("笔记本使用电池")
    macBookPro.connectPowerSource(macBookProBattery)
    macBookPro.inputVoltage()
    print("\n 电池没电了，使用对象适配器")
    //适配器插入插座
    macBookProObjectAdapter.insertSocket(socket)
    //macbookpro连接适配器
    macBookPro.connectPowerSource(macBookProObjectAdapter)
    //电流输出
    macBookPro.inputVoltage()
    print("\n 使用类适配器")
    macBookPro.connectPowerSource(macBookProClassAdapter)
    macBookPro.inputVoltage()
    print("============示例2:火鸡适配器")
    var duck22 : Duck2 = MallardDuck2()
    var turkey: Turkey = wildTurkey()
    var turkeyAdapter: Duck2 = TurkeyAdapter(turkey)
    print("the turkey says......")
    turkey.gobble()
    turkey.fly()
    print("the duck says......")
    duck22.quack()
    duck22.fly()
    print("the adapter says......")
    turkeyAdapter.quack()
    turkeyAdapter.fly()
    print("\n")
    
    print("==============外观模式==============")
    print("============示例1:无外观模式")
    //创建所需的对象
    let oxSocket: SocketType2 = OXSocket()
    let macbookpro: ComputerType = Macbookpro()
    let samsungDisplay: DisplayDeviceType = SamsungDisplay()
    print("每天上班要做的三件事：")
    oxSocket.on()
    macbookpro.start()
    samsungDisplay.on()
    print("\n每天下班要做的三件事：")
    samsungDisplay.off()
    macbookpro.shutdown()
    oxSocket.off()
    print("============示例2:外观模式")
    //给小弟派工作
    let everyDayWorking = EveryDayWorking()
    everyDayWorking.startWorking()
    print("\n")
    everyDayWorking.endWorking()
    print("\n")
    
    
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

//查看对象内存地址
func printAdress(_ values : AnyObject...){
    for value in values {
        print(Unmanaged.passUnretained(value).toOpaque())
    }
}
