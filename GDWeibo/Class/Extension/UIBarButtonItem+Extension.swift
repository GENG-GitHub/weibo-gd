//
//  UIBarButtonItem+Extension.swift
//  GDWeibo
//
//  Created by geng on 15/11/3.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    
    //便利构造函数
    convenience init(imageName: String)
    {
        let Btn = UIButton()
        Btn.setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
        Btn.setBackgroundImage(UIImage(named: "\(imageName)_highlighted"), forState: UIControlState.Highlighted)
        Btn.sizeToFit()
        
        self.init(customView:Btn)
    }
    
    
    //不创建对象就调用该方法创建Item
    class func creatBarButtonItem(imageName: String) -> UIBarButtonItem
    {
        let Btn = UIButton()
        Btn.setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
        
        Btn.setBackgroundImage(UIImage(named: "\(imageName)_highlighted"), forState: UIControlState.Highlighted)
        
        Btn.sizeToFit()
        
        return UIBarButtonItem(customView: Btn)
    }
    
    
    
    
}


