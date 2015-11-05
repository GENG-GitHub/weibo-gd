//
//  GDStatusForwardCell.swift
//  GDWeibo
//
//  Created by geng on 15/11/4.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDStatusForwardCell: GDStatusCell {

    
    //重写父类的方法
    override func prepareUI()
    {
        //调用父类的方法
        super.prepareUI()
    
        //添加子控件
        addSubview(backBtn)
    
        backBtn.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: nil ,offset:CGPoint(x: -8, y: 8))
        backBtn.ff_AlignVertical(type: ff_AlignType.TopRight, referView: bottomView, size: nil)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - 懒加载控件
    private lazy var forwardLabel: UILabel = {
       //创建label
        let label = UILabel()
        
        //设置属性
        label.numberOfLines = 0
        
        return label
        
    }()
    private lazy var backBtn: UIButton = {
       
        //创建按钮
        let btn = UIButton()
        
        //设置属性
        btn.backgroundColor = UIColor(white: 9.3, alpha: 0.9)
        
        return btn
    }()
    
    

}
