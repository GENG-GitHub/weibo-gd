//
//  GDStatusTopView.swift
//  GDWeibo
//
//  Created by geng on 15/11/3.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDStatusTopView: UIView {
    
    
    //为子控件赋值
    var status: GDStatus? {
        didSet {
            
            //设置头像
            if let iconUrl = status?.user?.profileImageUrl {
                iconView.sd_setImageWithURL(iconUrl)
            }
            
            //设置名字
            nameLabel.text = status?.user?.name
            
            //设置时间
            timeLabel.text = status?.created_at
            
            //设置来源 
//            sourceLabel.text = status?.source
            sourceLabel.text = "来自iPhone6s Plus"
            
            //设置认证图标
            verifiedView.image = status?.user?.verifiedTypeImage
            
            // 会员等级
            memberView.image = status?.user?.mbrankImage
        }
    }


    //MARK: - 构造方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    
        backgroundColor = UIColor.whiteColor()
        //设置子控件
        prepareUI()
        
    }
    
    
    //MARK: - 添加子控件
    private func prepareUI() {
        
        addSubview(topSeparatorView)
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(verifiedView)
        addSubview(memberView)
        
        // 添加约束
        /// 头像视图
//        iconView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: self, size: CGSize(width: 35, height: 35), offset: CGPoint(x: 8, y: 8))

        //顶部分割View
        // 顶部分割视图
        topSeparatorView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: self, size: CGSize(width: UIScreen.mainScreen().bounds.width, height: 10))
        
        iconView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: topSeparatorView, size: CGSize(width: 35, height: 35), offset: CGPoint(x: 8, y: 8))
        
        /// 名称
        nameLabel.ff_AlignHorizontal(type: ff_AlignType.TopRight, referView: iconView, size: nil, offset: CGPoint(x: 8, y: 0))
        
        /// 时间
        timeLabel.ff_AlignHorizontal(type: ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 8, y: 0))
        
        /// 来源
        sourceLabel.ff_AlignHorizontal(type: ff_AlignType.CenterRight, referView: timeLabel, size: nil, offset: CGPoint(x: 8, y: 0))
        
        /// 会员等级
        memberView.ff_AlignHorizontal(type: ff_AlignType.CenterRight, referView: nameLabel, size: CGSize(width: 14, height: 14), offset: CGPoint(x: 8, y: 0))
        
        /// 认证图标
        verifiedView.ff_AlignInner(type: ff_AlignType.BottomRight, referView: iconView, size: CGSize(width: 17, height: 17), offset: CGPoint(x: 8.5, y: 8.5))
    
        
    
    }

    //MARK: - 懒加载
    /// 用户头像
    private lazy var iconView = UIImageView()
    
    /// 用户名称
    private lazy var nameLabel: UILabel = UILabel(fontSize: 14, textColor: UIColor.darkGrayColor())
    
    /// 时间label
    private lazy var timeLabel: UILabel = UILabel(fontSize: 9, textColor: UIColor.orangeColor())
    
    /// 来源
    private lazy var sourceLabel: UILabel = UILabel(fontSize: 9, textColor: UIColor.lightGrayColor())
    
    /// 认证图标
    private lazy var verifiedView = UIImageView()
    
    /// 会员等级
    private lazy var memberView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    
    //懒加载顶部分割View
    private lazy var topSeparatorView: UIView = {
       
        let view = UIView()
        
        view.backgroundColor = UIColor(white: 0.9, alpha: 0.9)
        
        return view
        
    }()
    

}
