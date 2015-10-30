//
//  GDMainTabBar.swift
//  GDWeibo
//
//  Created by geng on 15/10/27.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDMainTabBar: UITabBar
{

    private let count: CGFloat = 5
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        //计算宽度
        let width = bounds.width / count
        
        //设置frame
        let frame = CGRect(x: 0, y: 0, width: width, height: bounds.height)
        
        //设置索引
        var index = 0
        //遍历子控件，设置frame
        for view in subviews
        {
            if view is UIControl 
            {
                print("view:\(view)")
                
                view.frame = CGRect(x: width * CGFloat(index) , y: 0, width: width, height: bounds.height)
                
//                view.frame = CGRectOffset(frame , width * CGFloat(index) , 0)
                
                index += index == 1 ? 2 : 1
            }
        }
        
        //设置按钮的frame
        composeButton.frame = CGRectOffset(frame, width * 2, 0)
        
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
        
        self.addSubview(btn)
        
        return btn
        
    }()
    
    
    
    
    
    
}
