//
//  GDVisitorView.swift
//  GDWeibo
//
//  Created by geng on 15/10/27.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit


protocol GDVisitorViewDelegate: NSObjectProtocol {
    
    func visitorViewWillRegister()
    func visitorViewWillLogin()
}

class GDVisitorView: UIView {

    //设置代理
   weak var visitorDelegate: GDVisitorViewDelegate?
    
    //MARK - 监听按钮的点击方法
    func loginBtnDidClick() {
        
        visitorDelegate?.visitorViewWillLogin()
    }
    
    func registerBtnDidClick() {
        
        visitorDelegate?.visitorViewWillRegister()
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        //创建子控件
        
        self.setupSubview()
    }

    
    
    //设置子控件
    func setupSubview() {
        
        //添加子控件
        addSubview(iconView)
        addSubview(bgView)
        addSubview(houseView)
        addSubview(messageLabel)
        addSubview(registerBtn)
        addSubview(loginBtn)
        
        
        //设置约束
        iconView.translatesAutoresizingMaskIntoConstraints = false
        houseView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        //蒙版
        bgView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        //创建约束
        //转轮
        addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterY
            , relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: -40))
        
        //小房子
        addConstraint(NSLayoutConstraint(item: houseView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: houseView, attribute:NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        //文字
        //x
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        //y
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute:NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        //width
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute:NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 240))
        
        //注册按钮
        //left
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        
        // top
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        
        // width
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
        
        // heigth
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 35))
        
        
        //登录按钮
        //right
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        
        // top
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        
        // width
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
        
        // heigth
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 35))
        
        
        //登录按钮
        //right
        addConstraint(NSLayoutConstraint(item: bgView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        
        // top
        addConstraint(NSLayoutConstraint(item: bgView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        
        // left
        addConstraint(NSLayoutConstraint(item: bgView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        
        // bottom
        addConstraint(NSLayoutConstraint(item: bgView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -200))
        
    }
    
    
    //创建转轮
    lazy var iconView: UIImageView = {
        
        //创建一个imageView
        let imageView = UIImageView()
        //创建一张image
        let image = UIImage(named: "visitordiscover_feed_image_smallicon")
        
        //自动填充
        imageView.sizeToFit()
        
        imageView.image = image
        
        return imageView
        
    }()
    
    //创建小房子
    lazy var houseView: UIImageView = {
        
        //创建一个imageView
        let imageView = UIImageView()
        //创建一张image
        let image = UIImage(named: "visitordiscover_feed_image_house")
        //自动填充
        imageView.sizeToFit()
        
        imageView.image = image
        
        return imageView
        
        }()
    
    
    //创建messageLabel
    lazy var messageLabel: UILabel = {
        
        //创建一个label
        let label = UILabel()
        //设置label的文字
        label.text = "关注一些人，看看有什么惊喜关注一些人"
        //自动换行
        label.numberOfLines = 0
        
        label.textColor = UIColor.lightGrayColor()
        
        //自动填充
        label.sizeToFit()
        
        return label
        
        }()
    
    
    //创建注册按钮
    lazy var registerBtn: UIButton = {
        
        //创建一个按钮
        let btn = UIButton()
        //设置背景
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        //设置字体颜色
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        //设置文字
        btn.setTitle("注册", forState: UIControlState.Normal)
        
        //自动填充
        btn.sizeToFit()
        
        
        btn.addTarget(self, action: "registerBtnDidClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        return btn
        
        }()
    
    
    //创建登录按钮
    lazy var loginBtn: UIButton = {
        
        //创建一个按钮
        let btn = UIButton()
        //设置背景
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        //设置字体颜色
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        //设置文字
        btn.setTitle("登录", forState: UIControlState.Normal)
        
        //自动填充
        btn.sizeToFit()
        
        btn.addTarget(self, action: "loginBtnDidClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        return btn
        
        }()
    
 
    lazy var bgView: UIImageView = {
        
        //创建一个UIImageView
        let bgImage = UIImageView()
        
        let image = UIImage(named: "visitordiscover_feed_mask_smallicon")
        
        
        bgImage.image = image
        
        return bgImage
        
    }()
    
    func setupVisiter(message: String, imageName: String)
    {
        
        messageLabel.text = message
        
        iconView.image = UIImage(named: imageName)
        
        //隐藏小房子
        houseView.hidden = true
        
        sendSubviewToBack(bgView)
        
    }
    
    func startRotationAnimation()
    {
        //创建基本动画
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        //设置转动的区域
        animation.toValue = 2 * M_PI
        //转一圈的时间
        animation.duration = 20
        //重复次数
        animation.repeatCount = MAXFLOAT
        
        
        //避免切换到其他的tabBar和回到桌面后重新进入时界面转轮不转了
        animation.removedOnCompletion = false
        
        //添加到转轮的图层上
        iconView.layer.addAnimation(animation, forKey: "Rotation")
        
    }
    
}




