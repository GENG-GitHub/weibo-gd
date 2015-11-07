//
//  GDComposeViewController.swift
//  GDWeibo
//
//  Created by geng on 15/11/6.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDComposeViewController: UIViewController {

    //MARK: - 属性
    //toolBar底部的约束
    private var toolBarBottomCons: NSLayoutConstraint?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        
        //添加监听键盘的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        //主动弹出键盘
        textView.becomeFirstResponder()
    }
    
    // MARK: - 键盘frame改变方法
    /// 键盘frame改变方法
    func keyboardWillChangeFrame(notifiction: NSNotification) {
//        print("notification: \(notifiction)")
        
        //获取键盘最终的frame
        let endFrame = notifiction.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        
        //toolBar的底部到父控件的底部
        toolBarBottomCons?.constant = -(UIScreen.mainScreen().bounds.height - endFrame.origin.y)
        
        // 获取动画时间
        let duration = notifiction.userInfo![UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
        
        // toolBar动画
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.layoutIfNeeded()
//            self.view.setNeedsLayout()
//            self.view.layoutSubviews()
        }
    }

    //准备UI
    private func prepareUI()
    {
        prepareNavigation()
        
        setToolBar()
        setupTextView()
    }
    
    
    //MARK: - 设置导航栏
    func prepareNavigation() {
        
        // 导航栏左边按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        
        // 导航栏右边按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Plain, target: self, action: "sendStatus")
        
        // 设置发送按钮为灰色
        navigationItem.rightBarButtonItem?.enabled = false
    
        //设置标题
        prepareNavTitle()
        
    }
    
    //设置导航栏标题
    func prepareNavTitle() {
        
        //设置文字前缀
        let prefix = "发微博"
        
        if let name = GDUserAccount.loadAccount()?.name{
            
            //创建一个label
            let nameLabel = UILabel()
            
            let titleName = prefix + "\n" + name
            
            //创建可变的文本
            let attrStr = NSMutableAttributedString(string: titleName)
            
            nameLabel.numberOfLines = 0
            nameLabel.textAlignment = NSTextAlignment.Center
            nameLabel.font = UIFont.systemFontOfSize(14)
            
            //获取用户名
            let nameRange = (titleName as NSString).rangeOfString(name)
           
            //修改指定范围的文字的属性
            attrStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12),range: nameRange)
            attrStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGrayColor(), range: nameRange)
            
            //为label赋值
            nameLabel.attributedText = attrStr
            nameLabel.sizeToFit()
            
            //修改导航栏的标题
            navigationItem.titleView = nameLabel
            
        }else
        {
            //没有名字时
            navigationController?.title = prefix
        }
    }
    
    
    //设置toolBar
    private func setToolBar()
    {
        //添加子控件
        view.addSubview(toolBar)
        
        //设置约束
        let cons = toolBar.ff_AlignInner(type: ff_AlignType.BottomLeft, referView: view, size: CGSizeMake(view.bounds.width, 44))
        //获取底部约束
        toolBarBottomCons = toolBar.ff_Constraint(cons, attribute: NSLayoutAttribute.Bottom)
        
        //创建toolBar上的item
        var items = [UIBarButtonItem]()
        
        // 每个item对应的图片名称
        let itemSettings = [["imageName": "compose_toolbar_picture", "action": "picture"],
            ["imageName": "compose_trendbutton_background", "action": "trend"],
            ["imageName": "compose_mentionbutton_background", "action": "mention"],
            ["imageName": "compose_emoticonbutton_background", "action": "emoticon"],
            ["imageName": "compose_addbutton_background", "action": "add"]]

        //循环遍历数组
        for dict in itemSettings
        {
            let item = UIBarButtonItem(imageName: dict["imageName"]!)
            
            let action = dict["action"]
            
            //为每个item添加点击事件
            let btn = item.customView as! UIButton
            //为按钮添加点击事件
            btn.addTarget(self, action: Selector(action!), forControlEvents: UIControlEvents.TouchUpInside)
            
            items.append(item)
            //添加弹簧
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil))
        }
        //删除最后一根弹簧
        items.removeLast()
        
        toolBar.items = items
        
    }
    
    //设置textView
    private func setupTextView() {
        
        //添加子控件
        view.addSubview(textView)
        
        //设置约束
        textView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: view, size: nil)
        textView.ff_AlignVertical(type: ff_AlignType.TopRight, referView: toolBar, size: nil)
        
    }
    
    
    
    //MARK: - 创建子控件
    private lazy var toolBar: UIToolbar = {
       
        //创建toolBar
        let toolBar = UIToolbar()
        //设置背景颜色
        toolBar.backgroundColor = UIColor(white: 0.8, alpha: 1)
        
        return toolBar
    }()
    
    private lazy var textView: GDPlaceHolderTextView = {
        
        let textView = GDPlaceHolderTextView()
        //设置textView背景
//        textView.backgroundColor = UIColor.brownColor()
        //设置contentInset
        textView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
        //设置textView有回弹效果
        textView.alwaysBounceVertical = true
        
        //拖动textView关闭键盘
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        
        textView.placeholder = "分享新鲜事..."
        textView.font = UIFont.systemFontOfSize(18)
        
        //设置代理
        textView.delegate = self
//        //实现显示占位文本
//        let placeHolder = UILabel()
//        placeHolder.text = "分享新鲜事..."
//        placeHolder.sizeToFit()
//        textView.addSubview(placeHolder)
        
        return textView
        }()
    
    
    // MARK: - toolBarItem 监听点击事件
    func picture() {
        print("图片")
    }
    
    func trend() {
        print("#")
    }
    
    func mention() {
        print("@")
    }
    
    func emoticon() {
        print("表情")
    }
    
    func add() {
        print("加号")
    }

    
    // MARK: - 按钮点击事件
    /// 关闭控制器
    @objc private func close() {
        //退出键盘
        textView.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /// 发微博
    func sendStatus() {
        print(__FUNCTION__)
    }
    

}

//MARK: - 实现UITextViewDelegate
extension GDComposeViewController: UITextViewDelegate
{
    
    func textViewDidChange(textView: UITextView) {
        
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
        
    }
    
    
    
}

