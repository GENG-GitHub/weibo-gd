//
//  GDMainViewController.swift
//  GDWeibo
//
//  Created by geng on 15/10/27.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        //KVC设置TabBar为自定义的TabBar
//        let mainTabBar = GDMainTabBar()
//        setValue(mainTabBar, forKey: "tabBar")
        //设置图片和文字颜色
//        tabBar.tintColor = UIColor.orangeColor()
        
        //首页
        let homeVC = GDHomeViewController()
        self.addChildViewController(homeVC, title: "首页", imageName: "tabbar_home")

        //消息
        let messageVC = GDMessageViewController()
        self.addChildViewController(messageVC, title: "消息", imageName: "tabbar_message_center")

        //添加一个中间的控制器
        let viewVC = UIViewController()
        self.addChildViewController(viewVC, title: "", imageName: "geng")

        
        //发现
        let discoverVC = GDDiscoverViewController()
        self.addChildViewController(discoverVC, title: "发现", imageName: "tabbar_discover")

        //我
        let profileVC = GDProfileViewController()
        self.addChildViewController(profileVC, title: "我", imageName: "tabbar_profile")

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //计算宽度
        let width = self.tabBar.bounds.width / 5
        
        //设置frame
        let frame = CGRect(x: 0, y: 0, width: width, height: tabBar.bounds.height)
        
        composeButton.frame = CGRectOffset(frame, width * 2, 0)
        
        tabBar.addSubview(composeButton)
        
    }
    
    
    /**
    私有方法：为tabBar控制器添加子控制器
    
    - parameter viewController: 待添加的控制器
    - parameter title:          标题
    - parameter imageName:      图片
    */
    private func addChildViewController(viewController: UIViewController , title: String, imageName: String)
    {
        viewController.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)
        self.addChildViewController(UINavigationController(rootViewController: viewController))
    }
    
    
    //懒加载按钮
    private lazy var composeButton: UIButton = {
        
        //创建按钮
        let btn = UIButton()
        
        //按钮的图片
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        //按钮的背景
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState:UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        return btn
        
        }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /**
    最初始的设置TabBar方式
    */
    private func setupTabBar()
    {
        
        //        //设置首页的标题
        //        homeVC.title = "首页"
        //        homeVC.tabBarItem.image = UIImage(named: "tabbar_home")
        //    homeVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], forState: UIControlState.Selected)
        //
        //        //修改图片的渲染模式
        //        let selectImg = UIImage(named: "tabbar_home_highlighted")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        //        homeVC.tabBarItem.selectedImage = selectImg
        
        //        //添加到tarBarVC中
        //        self.addChildViewController(UINavigationController(rootViewController: homeVC))
        
        //        //设置消息的标题
        //        messageVC.title = "消息"
        //        messageVC.tabBarItem.image = UIImage(named: "tabbar_message_center")
        //        //添加到tabBarVC中
        //        self.addChildViewController(UINavigationController(rootViewController: messageVC))
        
        
        //        //设置发现的标题
        //        discoverVC.title = "发现"
        //        discoverVC.tabBarItem.image = UIImage(named: "tabbar_discover")
        //        //添加到tabBarVC中
        //        self.addChildViewController(UINavigationController(rootViewController: discoverVC))
        
        
        
        //        //设置消息的标题
        //        profileVC.title = "我"
        //        profileVC.tabBarItem.image = UIImage(named: "tabbar_profile")
        //        //添加到tabBarVC中
        //        self.addChildViewController(UINavigationController(rootViewController: profileVC))
    }

}
