//
//  StatePattern.swift
//  DesignPattern
//
//  Created by 陈嘉琳 on 2019/11/13.
//  Copyright © 2019年 CJL. All rights reserved.
//

import Foundation


//MARK:------”状态模式“  State Pattern（ATM取款机）
/*
 状态模式：允许对象在内部状态改变时改变它的行为，对象看起来好像修够了它的类
 
 本质：状态模式其实就是封装了基于状态的行为，并将行为委托到当前状态中
 
 案例：从取款机中的各种状态，以及各种状态间的切换
 
 */

//MARK:------1、无“状态模式”的ATM
/*
 ATM的6种状态：无卡，有卡，解密，取款，取出金额，余额不足
 ATM的5种动作：插卡，退卡，输入密码，输入金额，确认取款
 */
enum ATMState{
    case NoBankCardState            //无卡
    case HasBankCardState           //有卡
    case DecodingState              //解密
    case FetchMoneyState            //可取款状态
    case OutMoneyState              //取款
    case InsufficientBalanceState   //余额不足
}

class ATM{
    //ATM默认状态是无卡状态
    var state: ATMState = .NoBankCardState
    //记录当前取款机中银行卡的余额
    var money: UInt = 0
    //存储用户想提取的金额
    var inputMoney: UInt = 0
    
    //插卡动作
    func insertBankCard(){
        switch state {
        case .NoBankCardState:
            state = .HasBankCardState
            money = 10_000
            print("已插入银行卡，现在可以输入密码或者退卡")
            
        case .HasBankCardState:
            print("目前已有银行卡，可以输入密码进行取款")
            
        case .DecodingState:
            print("目前处于解密状态，可以输入金额进行取款")
            
        case .FetchMoneyState:
            print("目前处于可取款状态，请点击确认按钮进行取款")
            
        case .OutMoneyState:
            print("已取款，你可以选择输入密码再次取款，或者退卡")
            
        case .InsufficientBalanceState:
            print("余额不足，你可以选择输入密码再次取款，或者退卡")
        }
    }
    
    //退卡动作
    func backBankCard(){
        switch state {
        case .NoBankCardState:
            print("无银行卡，无法退卡")
        case .HasBankCardState:
            fallthrough
        case .DecodingState:
            fallthrough
        case .FetchMoneyState:
            fallthrough
        case .InsufficientBalanceState:
            fallthrough
        case .OutMoneyState:
            state = .NoBankCardState
            print("已退卡")
        }
    }
    
    //输入密码动作
    func inputPassword(){
        switch state {
        case .NoBankCardState:
            print("无银行卡，无法进行输入密码操作，请插入银行卡")
            
        case .HasBankCardState:
            state = .DecodingState
            print("密码校验成功，现在可以输入金额进行取款")
            
        case .DecodingState:
            print("已输入密码，现在可以速入金额进行取款")
            
        case .FetchMoneyState:
            print("已输入取款金额，现在可进行取款")
            
        case .InsufficientBalanceState:
            state = .DecodingState
            print("余额不足，再次输入密码进行取款")
            
        case .OutMoneyState:
            state = .DecodingState
            print("已取款，再次输入密码进行取款")
            
        }
    }
    
    //输入金额动作
    func inputMoney(_ money: UInt){
        switch state {
        case .NoBankCardState:
            print("无银行卡，无法进行输入密码操作，请插入银行卡")
            
        case .HasBankCardState:
            print("请输入密码后方可进行取款操作")
            
        case .DecodingState:
            state = .FetchMoneyState
            self.inputMoney = money
            print("输入金额成功")
            
        case .FetchMoneyState:
            print("已输入取款金额，现在可进行取款")
            
        case .InsufficientBalanceState:
            print("余额不足，你可以选择输入密码再次取款，或者退卡")
            
        case .OutMoneyState:
            state = .DecodingState
            print("已取款，你可以选择输入密码再次取款，或者退卡")
            
        }
    }
    
    //确认取款动作
    func tapOkButton(){
        switch state {
        case .NoBankCardState:
            print("无银行卡，无法进行输入密码操作，请插入银行卡")
            
        case .HasBankCardState:
            print("请输入密码后方可进行取款操作")
            
        case .DecodingState:
            print("已输入密码，现在可以输入金额进行取款")
            
        case .FetchMoneyState:
            if inputMoney > money{
                state = .InsufficientBalanceState
                print("余额不足，你可以选择输入密码再次取款，或者退卡")
            }else{
                state = .OutMoneyState
                print("已输入取款金额，现在可进行取款")
            }
            
        case .InsufficientBalanceState:
            print("余额不足，你可以选择输入密码再次取款，或者退卡")
            
        case .OutMoneyState:
            state = .DecodingState
            print("已取款，你可以选择输入密码再次取款，或者退卡")
            
        }
    }
}

//MARK:------2、使用“状态模式”重构的ATM
/*
 换一种思路：
 1中是动作中包含各种状态 即 一种动作中有各种操作
 2中改成 将状态含有动作 即 一种状态下有这种操作
 
 最好的实现方式：为每个状态声明一个类，然后在类中实现该状态下的不同的操作
 */
//依赖接口编程，而不依赖实现编程
//两个接口：状态接口StateType（声明了状态要包含的动作）
protocol StateType{
    func insertBankCard()
    func backBankCard()
    func inputPassword()
    func inputMoney(_ money: UInt)
    func tapOkButton()
}
//ATM接口ATMType：也是ATM机的动作，所以遵循StateType
protocol ATMType: StateType {
    func getCardMoney()->UInt
    func getInputMoney()->UInt
    func changeState(_ state: ATMState)
}
//BaseStateClass所有状态的基类，依赖于ATMType，因为在状态中执行一些动作会修改ATM机的状态
class BaseStateClass: StateType{
    var atm: ATMType
    init(_ atm: ATMType) {
        self.atm = atm
    }
    func insertBankCard()  { }
    
    func backBankCard()  { }
    
    func inputPassword()  { }
    
    func inputMoney(_ money: UInt)  { }
    
    func tapOkButton() { }
}
//无卡状态类
class NoBankCardState: BaseStateClass{
    override func insertBankCard() {
        print("已插入银行卡，现在可以输入密码或者退卡")
        atm.changeState(.HasBankCardState)
    }
    
    override func backBankCard() {
        print("无卡状态，无法退卡")
    }
    
    override func inputPassword() {
        print("无银行卡，无法进行输入密码操作，请插入银行卡")
    }
    
    override func inputMoney(_ money: UInt) {
        print("无银行卡，无法进行输入取款金额操纵，请输入银行卡")
    }
    
    override func tapOkButton() {
        print("无银行卡，无法进行取款操作，请插入银行卡")
    }
}
//有卡状态类
class HasBankCardState: BaseStateClass{
    override func insertBankCard() {
        print("目前已经插入一张银行卡，不可以再次插入，现在可以输入密码进行取款")
    }
    
    override func backBankCard() {
        print("已退卡")
    }
    
    override func inputPassword() {
        atm.changeState(.DecodingState)
        print("密码校验成功，现在可以输入金额进行取款")
    }
    
    override func inputMoney(_ money: UInt) {
        print("你还没有进行密码验证，请输入密码后方可输入取款金额")
    }
    
    override func tapOkButton() {
        print("你还没有进行密码校验以及输入金额操作，请输入上述步骤后方可进行取款操作")
    }
}
//解密状态类
class DecodingState: BaseStateClass{
    override func insertBankCard() {
        print("目前已经插入一张银行卡，不可以再次插入，现在可以输入密码进行取款")
    }
    
    override func backBankCard() {
        print("已退卡")
    }
    
    override func inputPassword() {
        print("您的密码已经校验成功，请不要重复提交密码，现在可以输入金额进行取款")
    }
    
    override func inputMoney(_ money: UInt) {
        atm.changeState(.FetchMoneyState)
        print("输入金额成功，现在可以点击确认按钮进行取款")
    }
    
    override func tapOkButton() {
        print("你还没有输入金额操作，请输入上述步骤后方可进行取款操作")
    }
}
//取款状态类
class FetchMoneyState: BaseStateClass{
    override func insertBankCard() {
        print("目前已经插入一张银行卡，不可以再次插入，现在可以输入密码进行取款")
    }
    
    override func backBankCard() {
        print("已退卡")
    }
    
    override func inputPassword() {
        print("您的密码已经校验成功，请不要重复提交密码，现在可以输入金额进行取款")
    }
    
    override func inputMoney(_ money: UInt) {
        print("已输入取款金额，请不要重复提交，现在可以点击确认按钮进行取款操作")
    }
    
    override func tapOkButton() {
        if atm.getInputMoney() > atm.getCardMoney() {
            atm.changeState(.InsufficientBalanceState)
            print("余额不足，你可以选择输入密码再次取款，或者退卡")
        }else{
            atm.changeState(.OutMoneyState)
            print("已取款，你可以选择输入密码再次取款，或者退卡")
        }
        
    }
}
//已取款状态类
class OutMoneyState: BaseStateClass{
    override func insertBankCard() {
        print("目前已经插入一张银行卡，不可以再次插入，现在可以输入密码进行取款")
    }
    
    override func backBankCard() {
        print("已退卡")
    }
    
    override func inputPassword() {
        atm.changeState(.DecodingState)
        print("密码校验成功，现在可以输入金额进行取款")
    }
    
    override func inputMoney(_ money: UInt) {
        print("已输入取款金额，请不要重复提交，现在可以点击确认按钮进行取款操作")
    }
    
    override func tapOkButton() {
        print("取款成功，现在可以退卡或者再次输入密码进行取款操作")
    }
}
//余额不足状态类
class InsufficientBalanceState: BaseStateClass{
    override func insertBankCard() {
        print("目前已经插入一张银行卡，不可以再次插入，现在可以输入密码进行取款")
    }
    
    override func backBankCard() {
        print("已退卡")
    }
    
    override func inputPassword() {
        atm.changeState(.DecodingState)
        print("密码校验成功，现在可以输入金额进行取款")
    }
    
    override func inputMoney(_ money: UInt) {
        print("已输入取款金额，请不要重复提交，现在可以点击确认按钮进行取款操作")
    }
    
    override func tapOkButton() {
        print("余额不足，无法取款，现在可以退卡或者再次输入密码进行取款操作")
    }
}

class ATM2:ATMType{
    //stateType类型的对象 即 ATM机当前 所处的状态对象，默认是无卡状态类
    private var stateObject: StateType?
    private var cardMoney: UInt = 0
    private var inputMoney: UInt = 0
    
    init() {
        self.changeState(.NoBankCardState)
    }
    
    func getCardMoney() -> UInt {
        return cardMoney
    }
    
    func getInputMoney() -> UInt {
        return inputMoney
    }
    
    //可以提取出类封装成一个简单工厂方法
    func changeState(_ state: ATMState) {
        switch state {
        case .NoBankCardState:
            stateObject = NoBankCardState(self)
        case .HasBankCardState:
            stateObject = HasBankCardState(self)
        case .DecodingState:
            stateObject = DecodingState(self)
        case .FetchMoneyState:
            stateObject = FetchMoneyState(self)
        case .OutMoneyState:
            stateObject = OutMoneyState(self)
        case .InsufficientBalanceState:
            stateObject = InsufficientBalanceState(self)
        }
    }
    
    func insertBankCard() {
        self.cardMoney = 20000
        stateObject?.insertBankCard()
    }
    
    func backBankCard() {
        stateObject?.backBankCard()
    }
    
    func inputPassword() {
        stateObject?.inputPassword()
    }
    
    func inputMoney(_ money: UInt) {
        inputMoney = money
        stateObject?.inputMoney(money)
    }
    
    func tapOkButton() {
        stateObject?.tapOkButton()
    }
    
    
}



//MARK:---------测试用例
func test_StatePattern(){
    print("==============组合模式==============")
    print("======1、无状态模式下的ATM")
    let atm = ATM()
    print("------无卡状态下插入银行卡")
    atm.insertBankCard()
    
    print("\n------有卡状态下再次插入卡")
    atm.insertBankCard()
    
    print("\n------有卡状态输入密码")
    atm.inputPassword()
    atm.inputMoney(100)
    atm.tapOkButton()
    
    print("\n------取款后再次输入密码进行提款")
    atm.inputPassword()
    atm.inputMoney(100000)
    atm.tapOkButton()
    
    print("\n------退卡")
    atm.backBankCard()
    
    print("\n------无卡时调用输入密码操作")
    atm.inputPassword()
    
    print("\n======2、状态模式下重构的ATM")
    let atm2 = ATM2()
    print("------无卡状态下插入银行卡")
    atm2.insertBankCard()
    
    print("\n------有卡状态下再次插入卡")
    atm2.insertBankCard()
    
    print("\n------有卡状态输入密码")
    atm2.inputPassword()
    atm2.inputMoney(100)
    atm2.tapOkButton()
    
    print("\n------取款后再次输入密码进行提款")
    atm2.inputPassword()
    atm2.inputMoney(100000)
    atm2.tapOkButton()
    
    print("\n------退卡")
    atm2.backBankCard()
    
    print("\n------无卡时调用输入密码操作")
    atm2.inputPassword()
    print("\n")
}
