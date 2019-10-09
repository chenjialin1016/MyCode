//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Jialin Chen on 2019/7/18.
//  Copyright © 2019年 CJL. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        self.createTabbarVC()
        
        return true
    }
    
    func createTabbarVC(){
        let tabbarVC = UITabBarController.init()
        
        let vc1 = ViewController.init()
        vc1.view.backgroundColor = UIColor.red
        vc1.tabBarItem.title = "新闻"
        vc1.tabBarItem.image = UIImage.init(named: "icon.bundle/page@2x.png")
        vc1.tabBarItem.selectedImage = UIImage.init(named: "icon.bundle/page_selected@2x.png")
        
        let vc2 = UIViewController.init()
        vc2.view.backgroundColor = UIColor.yellow
        vc2.tabBarItem.title = "视频"
        vc2.tabBarItem.image = UIImage.init(named: "icon.bundle/video@2x.png")
        vc2.tabBarItem.selectedImage = UIImage.init(named: "icon.bundle/video_selected@2x.png")
        
        let vc3 = UIViewController.init()
        vc3.view.backgroundColor = UIColor.green
        vc3.tabBarItem.title = "推荐"
        vc3.tabBarItem.image = UIImage.init(named: "icon.bundle/like@2x.png")
        vc3.tabBarItem.selectedImage = UIImage.init(named: "icon.bundle/like_selected@2x.png")
        
        let vc4 = UIViewController.init()
        vc4.view.backgroundColor = UIColor.lightGray
        vc4.tabBarItem.title = "我的"
        vc4.tabBarItem.image = UIImage.init(named: "icon.bundle/home@2x.png")
        vc4.tabBarItem.selectedImage = UIImage.init(named: "icon.bundle/home_selected@2x.png")
        
        
        
        tabbarVC.viewControllers = [vc1, vc2, vc3, vc4]
        tabbarVC.delegate = self
        let navigationVC = UINavigationController.init(rootViewController: tabbarVC)
        self.window?.rootViewController = tabbarVC
        self.window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension AppDelegate : UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("did select")
    }
}
