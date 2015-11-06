//
//  GDStatusForwardCell.swift
//  GDWeibo
//
//  Created by geng on 15/11/4.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDStatusForwardCell: GDStatusCell {

    
    //MARK: - 重写父类的属性
    override var status:GDStatus? {
        didSet{
            
            //设置转发的文字
            let name = status?.retweeted_status?.user?.name ?? "没有名字"
            let text = status?.retweeted_status?.text ?? "没有内容"
            forwardLabel.text = "@\(name):\(text)"
           
        }
    }
    
    
    //MARK: - 重写父类的prepareUI方法
    //重写父类的方法
    override func prepareUI()
    {
        //调用父类的方法
        super.prepareUI()
    
        //添加子控件
        contentView.insertSubview(backBtn, belowSubview: pictureView)
        contentView.addSubview(forwardLabel)
    
        //设置背景View的约束
        backBtn.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: nil ,offset:CGPoint(x: -8, y: 8))
        backBtn.ff_AlignVertical(type: ff_AlignType.TopRight, referView: bottomView, size: nil)
        
        
        //设置转发微博文字的约束
        forwardLabel.ff_AlignInner(type: ff_AlignType.TopLeft, referView: backBtn, size: nil, offset: CGPoint(x: 8, y: 8))
        // 宽度约束
        contentView.addConstraint(NSLayoutConstraint(item: forwardLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: UIScreen.mainScreen().bounds.width - 2 * 8))
        
        //pictureView的约束
        // 在内容标签的左下位置,距离右r边为8,宽高为290, 290
        let cons = pictureView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: forwardLabel, size: CGSize(width: 290, height: 290), offset: CGPoint(x: 0, y: 8))
        // 获取配图视图的宽度约束
        pictureViewWidthCon = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Width)
        
        // 获取配图视图的高度约束
        pictureViewHeightCon = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Height)
        
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
        btn.backgroundColor = UIColor(white: 0.93, alpha: 1)
        
        return btn
    }()
    
    

}
