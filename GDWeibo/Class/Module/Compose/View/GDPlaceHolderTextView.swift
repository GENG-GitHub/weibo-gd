//
//  GDPlaceHolderTextView.swift
//  GDWeibo
//
//  Created by geng on 15/11/6.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDPlaceHolderTextView: UITextView {

    
    //MARK: - 属性
    var placeholder: String? {
        
        didSet {
            //设置占位文本
            placeholderLabel.text = placeholder
            placeholderLabel.sizeToFit()
        }
        
    }
    
    
    //MARK: - 构造方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        //设置UI
        prepareUI()
        
        //设置通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textViewDidChange:", name: UITextViewTextDidChangeNotification, object: self)
        
        
        
    }
    
    //注销通知
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: - 准备UI
    private func prepareUI()
    {
        //添加子控件
        addSubview(placeholderLabel)
        
        //设置约束
        placeholderLabel.ff_AlignInner(type: ff_AlignType.TopLeft, referView: self, size: nil, offset: CGPoint(x: 5, y: 8))
    }
    
    
    //MARK: - 懒加载
    //添加占位文本
    private lazy var placeholderLabel: UILabel =
    {
        let label = UILabel()
        //设置占位label属性
        label.textColor = UIColor.lightGrayColor()
        label.font = UIFont.systemFontOfSize(18)
        label.sizeToFit()
        
        return label
    }()
    
    
}



//MARK: - UITextViewDelegate
extension GDPlaceHolderTextView: UITextViewDelegate
{
    
    func textViewDidChange(textView: UITextView) {
        //如果文本框有文字时，就隐藏label
        placeholderLabel.hidden = hasText()
    }
}




