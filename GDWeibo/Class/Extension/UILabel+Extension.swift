//
//  UILabel+Extension.swift
//  GDWeibo
//
//  Created by geng on 15/11/3.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit


extension UILabel {
    
    //创建便利函数
    convenience init(fontSize: CGFloat, textColor: UIColor)
    {
        //调用本类的指定构造函数
        self.init()
        
        //设置文字大小
        self.font = UIFont.systemFontOfSize(fontSize)
        
        //设置文字颜色
        self.textColor = textColor
    }
}








