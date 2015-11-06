//
//  GDStatusNormaCell.swift
//  GDWeibo
//
//  Created by geng on 15/11/4.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDStatusNormaCell: GDStatusCell {


    override func prepareUI() {
        
        super.prepareUI()
        
        //pictureView的约束
        // 在内容标签的左下位置,距离右r边为8,宽高为290, 290
        
        let cons = pictureView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: CGSize(width: 290, height: 290), offset: CGPoint(x: 0, y: 8))
        // 获取配图视图的宽度约束
        pictureViewWidthCon = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Width)
        
        // 获取配图视图的高度约束
        pictureViewHeightCon = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Height)
    }
    
    
    
}
