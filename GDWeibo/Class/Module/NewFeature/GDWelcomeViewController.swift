//
//  GDWelcomeViewController.swift
//  GDWeibo
//
//  Created by geng on 15/11/1.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit
import SDWebImage

class GDWelcomeViewController: UIViewController {

    
    //头像底部约束
    private var iconViewBottemCons: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orangeColor()
        //设置UI
        prepareUI()
        
        //设置图像图片
        if let urlString = GDUserAccount.loadAccount()?.avatar_large
        {
            //根据路径下载图片并设置头像
            iconView.sd_setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "avatar_default_big"))
        }
        

    }
    
    override func viewDidAppear(animated: Bool) {
        
        //动画执行
        moveAnimation()
    }
    
    
    //MARK: - 头像动画
    private func moveAnimation() {
        
        //开始动画
        iconViewBottemCons?.constant = -(UIScreen.mainScreen().bounds.height - 160)
        
        //制作头像的动画过程
        UIView.animateWithDuration(1.0, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            
            //重新布局
            self.view.layoutIfNeeded()
            
            }, completion: { (_) -> Void in

                UIView.animateWithDuration(1 , animations: { () -> Void in
                    
                    self.label.alpha = 1
                    
                    }, completion: { (_) -> Void in
                        
                    //完成动画之后，跳转控制器，将文字显示，后跳转控制器
                        
                        (UIApplication.sharedApplication().delegate as? AppDelegate)?.window?.rootViewController = GDMainViewController()
                        
                })

        })
}
    
    func prepareUI() {
        
        //添加子控件
        view.addSubview(backgroundView)
        view.addSubview(iconView)
        view.addSubview(label)
        
        
        //背景
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        //添加约束
//        view.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
//        view.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
//        view.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
//        view.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        
        backgroundView.ff_Fill(view)
        
        
        //头像
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
//        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 85))
//        
//        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 85))
//        
//        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
//        
//        view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -160))

        let cons = iconView.ff_AlignInner(type: ff_AlignType.BottomCenter, referView: view, size: CGSize(width: 85, height: 85), offset: CGPoint(x: 0, y: -160))
        
        //记录下头像的底部约束
        iconViewBottemCons = iconView.ff_Constraint(cons, attribute: NSLayoutAttribute.Bottom)
        //文字
        label.translatesAutoresizingMaskIntoConstraints = false
        
//        view.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
//        
//        view.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        label.ff_AlignVertical(type: ff_AlignType.BottomCenter, referView: iconView, size: nil, offset: CGPoint(x: 0, y: 16))
        
     
    }
    
    
    
    //MARK： - 自定义子控件
    //背景
    private lazy var backgroundView: UIImageView = UIImageView(image: UIImage(named: "ad_background"))

    //头像
    private lazy var iconView: UIImageView = {
       
        //创建头像
        let imageView = UIImageView()
        let image = UIImage(named: "avatar_default_big")
        imageView.image = image
        
        //切割图片
        imageView.layer.cornerRadius = 42.5
        imageView.layer.masksToBounds = true
        
        return imageView
        
    }()
    
    //文字
    private lazy var label: UILabel = {
       
        //设置文字
        let label = UILabel()
        label.text = "欢迎归来"
        //设置文字的透明度
        label.alpha = 0
        
        label.sizeToFit()
        
        return label
        
    }()
    
    
    
    
    
    
    
    
    
    

}
