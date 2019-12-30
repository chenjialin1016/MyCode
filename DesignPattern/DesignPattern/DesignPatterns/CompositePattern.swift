//
//  CompositePattern.swift
//  DesignPattern
//
//  Created by 陈嘉琳 on 2019/11/7.
//  Copyright © 2019年 CJL. All rights reserved.
//https://www.cnblogs.com/ludashi/p/5439128.html

import Foundation

//MARK:------”组合模式“  Composite Pattern
/*
 组合模式：允许你将对象组合成树形结构来表现“整体/部分”层次结构（“树”形）。组合能让客户以一致的方式处理个别对象以及对象组合
 
 典型的树状层级关系：文件系统
 
 聚合 VS 组合
 【共同点】都是整体与部分的关系
 【不同】
 在聚合关系中，整体强烈依赖于部分，而部分脱离于整体将没有存在的意义，例如 身体器官 你
 对于组合关系来说整体与部分的依赖相对于小一些，离开彼此也是可以独立存在的，例如 员工 公司
 */


/*
 利用组合模式模拟文件结构：
 
 文件总体上分为两种类型，一是文件夹，二是真正有内容的文件
 */
//文件类型协议即协议扩展 FileType
protocol FileType {
    //用户获取文件名
    func getFileName()->String
    //用户添加文件
    func addFile(file: FileType)
    //y文件夹删除文件
    func deleteFile(file: FileType)
    //打印文件名
    func display()
}

extension FileType{
    func addFile(file: FileType){}
    func deleteFile(file: FileType){}
}


//文件夹的实现Folder 即 组合模式的核心模块，遵循了FileType接口，还依赖于FileType接口
class Folder: FileType{
    //组合的聚集地，可以存储文件和文件夹，组合模式的体现就是文件以及文件夹在一起进行组合会生成一个新的文件夹
    private var files: Dictionary<String, FileType> = Dictionary<String, FileType>()
    private var folderName: String
    
    init(_ folderName: String) {
        self.folderName = folderName
    }
    
    func getFileName() -> String {
        return self.folderName
    }
    
    func addFile(file: FileType) {
        files[file.getFileName()] = file
    }
    
    func deleteFile(file: FileType) {
        files.removeValue(forKey: file.getFileName())
    }
    
    func display() {
        let allKeys = Array(files.keys)
        print(getFileName())
        
        for i in 0..<allKeys.count {
            files[allKeys[i]]?.display()
        }
    }
    
    
}

//具体文件的类，该模块有一个基类BaseFile，需要遵循FileType接口，所有具体的文件都继承自BaseFile，
class BaseFile: FileType{
    private var fileName: String
    
    init(_ fileName: String) {
        self.fileName = fileName
    }
    
    func getFileName() -> String {
        return self.fileName
    }
    
    func display() {
        print(getFileName())
    }
    
}


class SwiftFile: BaseFile{}

class ObjCFile: BaseFile{}


//MARK:---------测试用例
func test_CompositePattern(){
    print("==============组合模式==============")
    //我们要实现的结构是一个树形结构
    /*
     -文件夹-rootFolder
     -Swift文件
     —Ojbc文件
     -子文件夹-SubFolder
     -Swift文件
     —Ojbc文件
     */
    
    //创建根文件夹
    let rootFolder: FileType = Folder("根文件夹")
    let objcFile1: FileType = ObjCFile("objc1.h")
    let swiftFile1: FileType = SwiftFile("file1.swift")
    rootFolder.addFile(file: objcFile1)
    rootFolder.addFile(file: swiftFile1)
    
    let subFolder: FileType = Folder("子文件夹")
    let objcFile2: FileType = ObjCFile("objc2.h")
    let swiftFile2: FileType = SwiftFile("file2.swift")
    subFolder.addFile(file: objcFile2)
    subFolder.addFile(file: swiftFile2)
    
    rootFolder.addFile(file: subFolder)
    
    //输出该目录下的所有文件夹和文件名
    rootFolder.display()
    print("\n")
}
