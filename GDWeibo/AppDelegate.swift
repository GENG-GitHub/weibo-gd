//
//  AppDelegate.swift
//  GDWeibo
//
//  Created by geng on 15/10/27.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      
        print("GDUserAccount:\(GDUserAccount.loadAccount())")
        print("GDUserAccount:\(GDUserAccount.loadAccount())")
        
        //创建UIWindow
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        

        
        window?.rootViewController = defaultController()
        //创建UITabBarController
//        let tabBarVC = GDMainViewController()
//        let tabBarVC = GDWelcomeViewController()
//        let tabBarVC = GDNewFeatureViewController()
        
        
        //显示窗口
        window?.makeKeyAndVisible()
        
        //设置导航控制器和tabBar控制器的全局外观
        self.setupAppearance()
        
        return true
    }
    
    
    //MARK： - 返回启动控制器
    private func defaultController() -> UIViewController {
        
        //判断是否登录
        if !GDUserAccount.userLogin() {
            
            return GDMainViewController()
        }
        
        //判断是否为新版本
        return isNewVersion() ? GDNewFeatureViewController() : GDWelcomeViewController()
        
    }

    
    private func isNewVersion() -> Bool {
        
        //判断新版本特性
        
        //获得当前的版本
        let currentVersion = Double((NSBundle.mainBundle()).infoDictionary!["CFBundleShortVersionString"] as! String)!
        
//        let currentVersion = 1.2
        print("currntVersion:\(currentVersion)")
        
        //获得之前沙盒保存的版本号
        let sandboxVersionKey = "sandboxVersionKey"
        
        //获得之前的版本
        let sandboxVersion = NSUserDefaults.standardUserDefaults().doubleForKey(sandboxVersionKey)
        
        print("sandboxVersion:\(sandboxVersion)")
        
//        //比较两个版本的大小
//        if currentVersion > sandboxVersion
//        {
//            let tabBarVC = GDNewFeatureViewController()
//            //设置窗口的根控制器
//            window?.rootViewController = tabBarVC
//        }
//        else
//        {
//            let tabBarVC = GDMainViewController()
//            //设置窗口的根控制器
//            window?.rootViewController = tabBarVC
//        }
        
        //将当前的版本保存到沙盒中
        NSUserDefaults.standardUserDefaults().setDouble(currentVersion, forKey: sandboxVersionKey)
        //更新沙盒
        NSUserDefaults.standardUserDefaults().synchronize()
        
        return currentVersion > sandboxVersion
    }
    
    
    
    
    
    
    private func setupAppearance()
    {
        //设置全局导航控制器的颜色
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()

        UITabBar.appearance().tintColor = UIColor.orangeColor()
    }
    
    
    
    
}

