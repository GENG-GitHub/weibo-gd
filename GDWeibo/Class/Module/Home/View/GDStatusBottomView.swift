//
//  GDStatusBottomView.swift
//  GDWeibo
//
//  Created by geng on 15/11/4.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDStatusBottomView: UIView {

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //设置底部View的背景颜色
        backgroundColor = UIColor(white: 0.96, alpha: 0.9)
        
        //设置子控件
        prepareUI()
    }

    
    //准备子控件
    func prepareUI()
    {
        //添加子控件
        addSubview(forwardButton)
        addSubview(commentButton)
        addSubview(likeButton)
        addSubview(separatorViewOne)
        addSubview(separatorViewTwo)
        
        //设置约束
        // 3个按钮水平平铺
        ff_HorizontalTile([forwardButton,commentButton,likeButton], insets: UIEdgeInsetsZero)
        
        /// 水平分割线
        separatorViewOne.ff_AlignHorizontal(type: ff_AlignType.CenterRight, referView: forwardButton, size: nil)
        separatorViewTwo.ff_AlignHorizontal(type: ff_AlignType.CenterRight, referView: commentButton, size: nil)
        
    }
    
    //MARK: - 懒加载子控件
    //转发
    private lazy var forwardButton: UIButton = UIButton(title: "转发", fontSize: 12, textColor: UIColor.darkGrayColor(), imageName: "timeline_icon_retweet")
    
    /// 评论
    private lazy var commentButton: UIButton = UIButton(title: "评论", fontSize: 12, textColor: UIColor.darkGrayColor(), imageName: "timeline_icon_comment")
    
    /// 赞
    private lazy var likeButton: UIButton = UIButton(title: "赞", fontSize: 12, textColor: UIColor.darkGrayColor(), imageName: "timeline_icon_unlike")
    
    /// 水平分割线
    private lazy var separatorViewOne: UIImageView = UIImageView(image: UIImage(named: "timeline_card_bottom_line_highlighted"))
    private lazy var separatorViewTwo: UIImageView = UIImageView(image: UIImage(named: "timeline_card_bottom_line_highlighted"))
 
}
