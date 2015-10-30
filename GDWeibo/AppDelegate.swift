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
      
        //创建UIWindow
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        //创建UITabBarController
        let tabBarVC = GDMainViewController()
        
        //设置窗口的根控制器
        window?.rootViewController = tabBarVC
        
        //显示窗口
        window?.makeKeyAndVisible()
        
        //设置导航控制器和tabBar控制器的全局外观
        self.setupAppearance()
        
        
        return true
    }

    
    private func setupAppearance()
    {
        //设置全局导航控制器的颜色
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()

        UITabBar.appearance().tintColor = UIColor.orangeColor()
    }
    
    
    
    
}

