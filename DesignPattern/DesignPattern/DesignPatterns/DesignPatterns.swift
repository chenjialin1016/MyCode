//
//  DesignPatterns.swift
//  test
//
//  Created by Jialin Chen on 2019/7/1.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//https://www.cnblogs.com/ludashi/p/5395849.html

import UIKit

func designPatternsTest(){
    
    test_StrategyPattern()
    
    test_ObservePattern()
    
    test_DecoratorPattern()
    
    test_FactoryPattern()
    
    test_SingletonPattern()
    
    test_CommandPattern()
    
    test_AdapterPattern()
    
    test_FacadePattern()
    
    test_TemplateMethodPattern()
    
    test_IteratorPattern()
    
    test_CompositePattern()
    
    test_StatePattern()
    
    test_ProxyPattern()
    
}

//查看对象内存地址
func printAdress(_ values : AnyObject...){
    for value in values {
        print(Unmanaged.passUnretained(value).toOpaque())
    }
}
