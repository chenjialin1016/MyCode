//
//  从FQ中认识代理模式
//https://www.cnblogs.com/ludashi/p/5454189.html

import Foundation

//MARK:---------代理模式 Proxy Pattern
/*
 代理模式：为另一个对象提供一个替身或者占位符已控制对这个对象的访问
 
 通俗理解：比如你要买棵萝卜，那么一般人不会去找菜农，然后给他们钱直接去地里薅萝卜。大部分人是通过商超来获取萝卜，这些商超就是所谓的萝卜代理商，也就是二道贩子。
 
 保护代理：控制访问远程对象
 远程代理：基于权限的资源访问，
 虚拟代理：控制访问创建开销大的资源
 */


//MARK:---------1、保护代理模式 GFW-长城防火墙 2、远程代理模式 shadowsocks
/*
 远程代理：远程代理的态度是Open&Freedom的，只负责桥接，至于你访问的什么网站它不做关心，它只负责响应你的请求
 保护代理：GreatFirewall是一个保护代理，其中有一个blackList（黑名单），如下所示。blackList数组中记录的就是那些被墙的网站，只要是请求的网站在blackList中，你的请求是不会得到你请求网站的响应的
 
 三部分：
 访问的网站：定义了InternetAccessProtocol协议（接口）来模拟这些Web站点所遵循的网络协议
 核心部分：网络代理部分，声明了一个协议ProxyType
 Client：Client只能依赖于代理进行网络访问
 */

//网络访问访问协议与web站点的实现
protocol InternetAccessProtocol {
    func response()
    func getId()->String
}

class Facebook: InternetAccessProtocol{
    func response() {
        print("您好，欢迎访问脸书")
    }
    
    func getId() -> String {
        return "Facebook"
    }
}

class Twitter: InternetAccessProtocol{
    func response() {
        print("您好，欢迎访问推特")
    }
    
    func getId() -> String {
        return "Twitter"
    }
}

class Cnblogs: InternetAccessProtocol{
    func response() {
        print("您好，欢迎访问博客园")
    }
    
    func getId() -> String {
        return "Cnblogs"
    }
}

//两种代理的实现
//代理协议
protocol Proxy: InternetAccessProtocol {
    //设置代理 即 设置访问的web站点
    func setDelegate(_ delegate: InternetAccessProtocol)
}
//=========远程代理
class ShadowsocksProxy: Proxy{
    
    private var delegate: InternetAccessProtocol? = nil
    
    init(_ delegate: InternetAccessProtocol? = nil) {
        self.delegate = delegate
    }
    
    func setDelegate(_ delegate: InternetAccessProtocol) {
        self.delegate = delegate
    }
    
    func response() {
        delegate?.response()
    }
    
    func getId() -> String {
        return "ShadowsocksProxy"
    }
    
    
}
//=========保护代理：多一项权限的控制
class GreatFirewall: Proxy{
    
    //黑名单
    private var blackList: Array<String> = [Facebook().getId(), Twitter().getId()]
    private var delegate: InternetAccessProtocol? = nil
    
    func setDelegate(_ delegate: InternetAccessProtocol) {
        if hasInTheBlackList(delegate){
            print("您访问的\(delegate.getId())不可用")
            self.delegate = nil
        }else{
            self.delegate = delegate
        }
    }
    
    func response() {
        self.delegate?.response()
    }
    
    func getId() -> String {
        return (delegate?.getId())!
    }
    
    //判断是否被墙
    func hasInTheBlackList(_ website: InternetAccessProtocol)->Bool{
        return blackList.contains{ (item) -> Bool in
            if website.getId() == item{
                return true
            }else{
                return false
            }
        }
    }
}

//client
class Client{
    private var shadowsocksProxy: Proxy = ShadowsocksProxy()
    private var greatFirewall: Proxy = GreatFirewall()
    
    func useProxyAccessWebSite(_ website: InternetAccessProtocol){
        shadowsocksProxy.setDelegate(website)
        shadowsocksProxy.response()
    }
    
    func useGreateFirewall(_ website: InternetAccessProtocol){
        greatFirewall.setDelegate(website)
        greatFirewall.response()
    }
}

//MARK:---------3、虚拟代理模式
/*
 作用：为占用存储空间比较大的对象提供替身
 
 通俗理解：在大对象的使用者 和 大对象 间添加了一层
 */
protocol ImageType{
    func imageLoad()
}

class BigImage: ImageType{
    func imageLoad() {
        print("大图片")
    }
}

class SmallImage: ImageType{
    func imageLoad() {
        print("小占位图片")
    }
}

//图片虚拟代理
class BigImageProxy: ImageType{
    
    var bigImage: ImageType? = nil
    var bigImageNoInit: Bool = true
    var smallImage: ImageType? = nil
    
    func imageLoad() {
        if bigImage != nil {
            bigImage?.imageLoad()
        }else{
            smallImage?.imageLoad()
            
            if bigImageNoInit {
                //模拟长时间的初始化
                self.bigImage = BigImage()
                bigImageNoInit = false
            }
        }
    }
}

class ImageClient {
    var image: ImageType?
    
    func setImage(_ image: ImageType)->Void{
        self.image = image
    }
    
    func imageLoad(){
        image?.imageLoad()
    }
}


//MARK:---------测试用例
func test_ProxyPattern(){
    print("==============代理模式==============")
    print("======1、远程代理、保护代理")
    let client = Client()
    print("使用远程代理直接访问Facebook：")
    client.useProxyAccessWebSite(Facebook())
    
    print("\n经过防火墙直接访问Facebook：")
    client.useGreateFirewall(Facebook())
    
    print("\n经过防火墙访问远程代理，然后使用远程代理来访问Facebook：")
    client.useGreateFirewall(ShadowsocksProxy(Facebook()))
    
    print("\n经过防火墙直接访问博客园：")
    client.useGreateFirewall(Cnblogs())
    
    print("======2、虚拟代理")
    let imageClient = ImageClient()
    imageClient.setImage(BigImage())
    imageClient.imageLoad()
    imageClient.imageLoad()
    print("\n")
}
