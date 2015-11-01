//
//  GDBasicViewController.swift
//  GDWeibo
//
//  Created by geng on 15/10/27.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDBasicViewController: UITableViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
 
    }
    
    //根据用户是否登录上网
    let userLogin = false
    
    var visitorView: GDVisitorView?
    
    override func loadView()
    {
        
        userLogin ? super.loadView() : setupVisitorView()
        
    }

    //创建访客视图
    func setupVisitorView() {
        
        visitorView = GDVisitorView()
        
        view = visitorView
        //设置背景颜色
        view.backgroundColor = UIColor(white: 237/255, alpha: 1.0)
        
        if self is GDHomeViewController{
         
            //旋转轮盘
            visitorView?.startRotationAnimation()
            
        }
        else if self is GDMessageViewController{
            
            //信息界面
            visitorView?.setupVisiter("登录后，别人评论你的微博l，发给你的消息，都会在这里收到通知", imageName: "visitordiscover_image_message")
        }
        else if self is GDDiscoverViewController {
            
            //发现界面
            visitorView?.setupVisiter("登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过", imageName: "visitordiscover_image_message")
        }
        else if self is GDProfileViewController
        {
            //我界面
            visitorView?.setupVisiter("登录后，你的微博、相册、个人资料会显示在这里，展示给别人", imageName: "visitordiscover_image_profile")
        }
        
        //设置代理
        visitorView?.visitorDelegate = self
        
        // 添加导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "visitorViewWillRegister")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "visitorViewWillLogin")
        
    }
    

}

extension GDBasicViewController: GDVisitorViewDelegate {
    
    func visitorViewWillRegister()
    {
        print(__FUNCTION__)
    }
    func visitorViewWillLogin()
    {
        let oauthVC = GDOauthViewController()
        
        presentViewController(UINavigationController(rootViewController: oauthVC), animated: true, completion: nil)
        
    }
  
}













