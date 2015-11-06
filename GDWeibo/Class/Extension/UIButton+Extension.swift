//
//  UIButton+Extension.swift
//  GDWeibo
//
//  Created by geng on 15/11/4.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

extension UIButton {
    

    convenience init(title: String, fontSize: CGFloat, textColor: UIColor, imageName: String) {
        self.init()
        
        // 文字内容
        setTitle(title, forState: UIControlState.Normal)
        
        // 文字大小
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        
        // 文字颜色
        setTitleColor(textColor, forState: UIControlState.Normal)
        
        // 图片
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
    }
}















