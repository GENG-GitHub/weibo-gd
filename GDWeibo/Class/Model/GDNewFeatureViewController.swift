//
//  GDNewFeatureViewController.swift
//  GDWeibo
//
//  Created by geng on 15/11/1.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class GDNewFeatureViewController: UICollectionViewController {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置流水布局
    let layout = UICollectionViewFlowLayout()
    
    //重写init
    init() {
        super.init(collectionViewLayout: layout)
        
        prepareLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册cell
        self.collectionView?.registerClass(GDNewFeatureViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    //设置item的个数
    let itemCount = 4

    //设置layout的参数
    private func prepareLayout() {
        
        //设置item的大小
        layout.itemSize = UIScreen.mainScreen().bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        //滚动方向为水平
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        
        //设置分页
        collectionView?.pagingEnabled = true
        //去除弹簧效果
        collectionView?.bounces = false
        //去除水平滚动条
        collectionView?.showsHorizontalScrollIndicator = false
        
        
        
    }
    
// MARK: UICollectionViewDataSource
override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return itemCount
    }

    //当cell显示完毕之后
override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath)
{
    
    //获取当前显示的cell的path
    let indexPath = collectionView.indexPathsForVisibleItems().first

    //转化为自定义的cell
    let cell = collectionView.cellForItemAtIndexPath(indexPath!) as? GDNewFeatureViewCell
    
    print("indexPath.item\(indexPath!.item)")
    
    //执行动画
    if indexPath!.item == itemCount - 1
    {
        cell?.startBtnAnimation()
    }
    
}
override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    //创建cell
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? GDNewFeatureViewCell

    //为cell赋值
    cell?.imageIndex = indexPath.item
    
        return cell!
    }

}


// MARK: - 自定义cell
class GDNewFeatureViewCell: UICollectionViewCell {
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        //设置子控件
        prepareUI()
    }

    
    //开始按钮动画
    func startBtnAnimation() {
        
        //显示按钮
        starButton.hidden = false
        
        //设置按钮的transform
        starButton.transform = CGAffineTransformMakeScale(0, 0)
        
        
        //动画还原按钮
        UIView.animateWithDuration(1.0, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            
            self.starButton.transform = CGAffineTransformIdentity
            
            }, completion: { (_) -> Void in
                
                
                
        })
    }
    
    //设置cell上UI界面
    func prepareUI() {
        
        //添加子控件
        contentView.addSubview(backgroudView)
        contentView.addSubview(starButton)
        
        //设置背景图片约束
        backgroudView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bgv]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bgv" : backgroudView]))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[bgv]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bgv" : backgroudView]))
        
        //设置按钮图片约束
        starButton.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: starButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
         addConstraint(NSLayoutConstraint(item: starButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -160))
        
        
    }
    
    //MARK: - 开始按钮的监听方法
    func startButtonClick() {
        
        (UIApplication.sharedApplication().delegate as? AppDelegate)?.window?.rootViewController = GDMainViewController()
        
    }
 
    //MARK: - 懒加载子控件
    //懒加载背景图片
    private lazy var backgroudView = UIImageView()
    
    //获取图片的名称
    var imageIndex: Int? = 0 {
    
        didSet {
            
            backgroudView.image = UIImage(named: "new_feature_\(imageIndex! + 1)")
            //开始按钮设置为隐藏
            starButton.hidden = true
        }
        
    }
    
    
    //设置按钮
    lazy var starButton: UIButton = {
    
        //创建按钮
        let button = UIButton()
        
        button.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
        
        //设置按钮文字信息
        button.setTitle("开始体验", forState: UIControlState.Normal)
        
        button.addTarget(self, action: "startButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        return button
        
    }()
    
}









