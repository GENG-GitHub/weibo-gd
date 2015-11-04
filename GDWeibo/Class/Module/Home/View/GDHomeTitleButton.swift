//
//  GDHomeTitleButton.swift
//  GDWeibo
//
//  Created by geng on 15/11/3.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDHomeTitleButton: UIButton {

    //返回创建好的按钮
    convenience init(title: String){
        
        self.init()
        //设置按钮的文字和图片
        setTitle(title, forState: UIControlState.Normal)
        setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        sizeToFit()
    }
    
    
    override func layoutSubviews() {
        
        //调用父类的方法
        super.layoutSubviews()
        
        //设置按钮文字的位置
        titleLabel?.frame.origin.x = 0
        
        //设置按钮图片的位置
        imageView?.frame.origin.x = (titleLabel?.frame.width)! + 5
        
    }

}
