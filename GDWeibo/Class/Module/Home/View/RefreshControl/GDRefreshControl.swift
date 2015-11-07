//
//  GDRefreshControl.swift
//  GDWeibo
//
//  Created by geng on 15/11/5.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDRefreshControl: UIRefreshControl {
    
    //MARK: - 属性
    private let RefreshControlOffest: CGFloat = -60
    
    //MARK: - 记录箭头的指向
    private var isUp = false
    
    //重写父类的frame属性
    override var frame:CGRect {
        
        didSet{
            
            if frame.origin.y >= 0 {
                return
            }
            
            //如果当前菊花在转
            if refreshing
            {
                refreshView.startLoading()
            }
            
            
            if frame.origin.y > RefreshControlOffest && !isUp
            {
                print("箭头向上")
                isUp = true
                refreshView.startRotateTipView(isUp)
                return
            }else if frame.origin.y < RefreshControlOffest && isUp
            {
                print("箭头向下")
                isUp = false
                refreshView.startRotateTipView(isUp)
                return
            }
            
            
        }
        
    }

    
    //MARK: - 重写endRefreshingfangf
    override func endRefreshing() {
        //停止系统的菊花
        super.endRefreshing()
        
        //停止自己定义的菊花转动
        refreshView.stopRotating()
        
    }
    
    
    
    //MARK: - 重写构造方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        //设置菊花的颜色
        tintColor = UIColor.clearColor()
      
        //设置子控件
        prepareUI()
        
    }
    
    //准备子控件
    func prepareUI()
    {
        //设置子控件
        self.addSubview(refreshView)
        
        
        //添加约束,这里的size必须要设置，否则出现意想不到的结果
        refreshView.ff_AlignInner(type: ff_AlignType.CenterCenter, referView: self, size: refreshView.bounds.size)
    }
    
   //MARK: - 懒加载
    private lazy var refreshView: GDRefreshView = GDRefreshView.refreshView()

}


//MARK: - 自定义
class GDRefreshView: UIView
{
    //下拉刷新View
    @IBOutlet weak var tipView: UIView!
    //箭头
    @IBOutlet weak var tipIcon: UIImageView!
    //加载圆圈
    @IBOutlet weak var loadingIcon: UIImageView!
    

    
    //MARK: - 类方法加载xib
    class func refreshView() -> GDRefreshView {
        
        return NSBundle.mainBundle().loadNibNamed("GDRefreshView", owner: nil, options: nil).last as! GDRefreshView
    }
    
    //开始转动箭头
    func startRotateTipView(isUp: Bool)
    {
        //动画移动箭头
        UIView.animateWithDuration(0.25) { () -> Void in
            self.tipIcon.transform = isUp ? CGAffineTransformIdentity : CGAffineTransformMakeRotation(CGFloat(M_PI - 0.01))
        }
     
    }
    
    //停止转动
    func stopRotating()
    {
        //显示下拉刷新View
        tipView.hidden = false
        
        //移除动画
        loadingIcon.layer.removeAllAnimations()
    }

    //开始加载
    func startLoading(){
        
        
        let animKey = "animKey"
        //如果当前有动画在执行就返回
        if let _ = loadingIcon.layer.animationForKey(animKey)
        {
            return
        }
        
        
        //隐藏箭头View
        tipView.hidden = true
        
        //动画旋转圆圈
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        //设置动画时间
        animation.duration = 0.25
        //设置动画次数
        animation.repeatCount = MAXFLOAT
        //设置动画范围
        animation.toValue = 2 * M_PI
        //仿真切换控制器动画被停止
        animation.removedOnCompletion = false
        
        //添加动画到layer上
        loadingIcon.layer.addAnimation(animation, forKey: animKey)
        
        
    }
    
    
}













