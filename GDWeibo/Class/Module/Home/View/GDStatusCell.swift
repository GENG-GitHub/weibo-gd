//
//  GDStatusCell.swift
//  GDWeibo
//
//  Created by geng on 15/11/3.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDStatusCell: UITableViewCell {

    // MARK: - 属性
    /// 配图宽度约束
    private var pictureViewWidthCon: NSLayoutConstraint?
    
    /// 配图高度约束
    private var pictureViewHeightCon: NSLayoutConstraint?
 
    var status: GDStatus? {
        didSet {
            // 将模型赋值给topView
            topView.status = status
            //为微博文本内容赋值
            contentLabel.text = status?.text
           
            //为微博配图高度赋值
//            pictureViewHeightCon?.constant = 90
            pictureView.status = status
            //获得item的CGSize
            let size: CGSize = pictureView.calcViewSize()
            //重新设置约束
            pictureViewWidthCon?.constant = size.width
            pictureViewHeightCon?.constant = size.height
        }
    }

    //MARK: - 重写构造方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    //设置子控件
    prepareUI()
    
    }


     func prepareUI() {
        
        //添加头部View
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(pictureView)
        contentView.addSubview(bottomView)
        
        //设置约束
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        topView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: contentView, size: CGSize(width: UIScreen.mainScreen().bounds.width, height: 54))
        contentLabel.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: topView, size: nil, offset: CGPoint(x: 8, y: 8))
        //设置label的宽度
        contentView.addConstraint(NSLayoutConstraint(item: contentLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: UIScreen.mainScreen().bounds.width - 2 * 8))
        // contentView的底部和contentLabel的底部重合
//        contentView.addConstraint(NSLayoutConstraint(item: contentLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        
        
        //pictureView的约束
        // 在内容标签的左下位置,距离右r边为8,宽高为290, 290
        
        let cons = pictureView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: CGSize(width: 290, height: 290), offset: CGPoint(x: 0, y: 8))
        contentView.addConstraint(NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: pictureView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 8))
        
        
        // 获取配图视图的宽度约束
        pictureViewWidthCon = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Width)
        
        // 获取配图视图的高度约束
        pictureViewHeightCon = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Height)

        
        //设置底部View的约束
        // 在微博内容下面8,左边和父控件对齐,右边和父控件对齐,高度44
        
//        contentView.addConstraint(NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 8))
//        contentView.addConstraint(NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: pictureView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 8))
//        
//        contentView.addConstraint(NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
//        
//        contentView.addConstraint(NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 44))
        
        bottomView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: pictureView, size: CGSize(width: UIScreen.mainScreen().bounds.width, height: 44), offset: CGPoint(x: -8, y: 8))
        
        // contentView的底部和bottomView的底部重合
//        contentView.addConstraint(NSLayoutConstraint(item: bottomView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        
 
    }
    
    //MARK: - 懒加载
    //顶部View
    private lazy var topView: GDStatusTopView = GDStatusTopView()
    
    //内容
    lazy var contentLabel: UILabel =  {
       
        //创建一个label
        var label = UILabel()
        //设置自动换行
        label.numberOfLines = 0
        
        return label
    }()

    ///底部View
    lazy var bottomView: GDStatusBottomView = GDStatusBottomView()
    /// 显示微博配图的View
    private lazy var pictureView: GDStatusPictureView = GDStatusPictureView()
    
    
    //自行计算行高
    func rowHeight(status: GDStatus) -> CGFloat{
        
        //重新设置cell里面的控件的内容
        self.status = status
        
        //重新布局
        layoutIfNeeded()
        
        //返回最大高度：即bottemView的最大Y值
        return CGRectGetMaxY(bottomView.frame)
        
    }
    
    
    
    
}
