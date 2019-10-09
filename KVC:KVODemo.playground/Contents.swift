import UIKit

//在swift中为一个类实现kvc，需要让它继承NSObject,并且在属性前加上@objc
class Person: NSObject{
    @objc var firstName: String
    @objc var lastName: String
    
    init(_ firstName: String, _ lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

var p = Person("Lucky", "Roc")
//使用kvc机制赋值的方式
p.setValue("swift", forKey: "firstName")
//使用直接引用属性的方式
print(p.lastName)
//使用kvc机制访问的方式
print(p.value(forKey: "lastName"))


//kvc的运行机制：
//setValue: forKey ===》 如果没有找到Set<Key>方法的话，会按照_key，_iskey，key，iskey的顺序搜索成员并进行赋值操作
//valueForKey

//valueForKeyPath 一个类中的成员变量可能是其他的自定义类
class Address: NSObject{
    @objc var firstLine: String
    @objc var secondLine: String
    init(_ firstLine: String, _ secondLine: String) {
        self.firstLine = firstLine
        self.secondLine = secondLine
    }
}
class PersonHandleKeyPath: NSObject{
    @objc var firstName: String
    @objc var lastName: String
    @objc var address: Address
    init(_ firstName: String, _ lastName: String, _ address: Address) {
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
    }
    
    override func value(forUndefinedKey key: String) -> Any? {
        return "key:\(key)不存在"
    }
    override func setNilValueForKey(_ key: String) {
        print("给\(key)传值为nil")
    }
}

var personKeyPath = PersonHandleKeyPath("Lucky", "Roc", Address("Nanjing", "ZhujiangRoad"))
print(personKeyPath.value(forKeyPath: "address.firstLine"))

personKeyPath.setValue(nil, forKey: "firstName")
personKeyPath.value(forKey: "age")


//kvc使用场景
/*
 1、单层字典模型转换：字典转model
 2、ios黑魔法：通过runtime获取空间API未暴露的属性，自定义修改
 3、使用valueForKeyPath可以获取数组中的最小值、最大值、平均值、求和
 */
