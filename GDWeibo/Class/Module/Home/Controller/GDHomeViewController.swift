//
//  GDHomeViewController.swift
//  GDWeibo
//
//  Created by geng on 15/10/27.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit
import SVProgressHUD

enum GDStatusCellIndentifier: String {
    case NormalCell = "NormalCell"
    case ForwardCell = "ForwardCell"
}

class GDHomeViewController: GDBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //如果还没有登陆就直接返回 
        if GDUserAccount.loadAccount() == nil {
            
            return
        }
        
        refreshControl = GDRefreshControl()
        //下拉刷新--加载微博数据
        refreshControl?.addTarget(self, action: "loadStatus", forControlEvents: UIControlEvents.ValueChanged)
        //让下拉的view进入刷新的view,不会促发事件ValueChanged
        refreshControl?.beginRefreshing()
        //发送指定事件给refreshControl
        refreshControl?.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        
        //注册cell
        tableView.registerClass(GDStatusNormaCell.self, forCellReuseIdentifier: GDStatusCellIndentifier.NormalCell.rawValue)
        tableView.registerClass(GDStatusForwardCell.self, forCellReuseIdentifier: GDStatusCellIndentifier.ForwardCell.rawValue)
        
//        tableView.rowHeight = 100

        //预设行高
        tableView.estimatedRowHeight = 300
        //设置自动行高
        tableView.rowHeight = UITableViewAutomaticDimension
        //设置底部View
        tableView.tableFooterView = pullUpView
//        pullUpView.startAnimating()
        
        // 去掉分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        //设置导航控制器
        setNavgationBar()
        //加载微博数据
//        loadStatus()
        
    }
    
    //MARK: - 懒加载属性
    //获取微博数据
    private var statuses = [GDStatus]() {
        
        didSet{
            //每次赋值时都刷新数据
            tableView.reloadData()
        }
    }
    private lazy var pullUpView: UIActivityIndicatorView = {
        
        //创建View
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        //设置菊花颜色
        indicator.color = UIColor.magentaColor()
        
        return indicator
    }()
    //下拉刷新提示方法
    private func showPullDownTip(count: Int) {
        
        tipLabel.text = count == 0 ? "没有新的微博数据" : "加载了\(count)条微博"
        
        let frame = tipLabel.frame
        
        //动画移动label
        UIView.animateWithDuration(0.75, animations: { () -> Void in
            
            self.tipLabel.frame.origin.y = (self.navigationController?.navigationBar.frame.height)!
            
            }) { (_) -> Void in
                
                UIView.animateWithDuration(0.75, delay: 0.2, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                    
                    self.tipLabel.frame = frame
                    
                    }, completion: { (_) -> Void in
                        
                })
                
        }
    }
    
    //提示View
    private lazy var tipLabel: UILabel = {
    
         //创建一个label
        let label = UILabel()
        
        //设置label的属性
        let labelHight: CGFloat = 44
        label.backgroundColor = UIColor.orangeColor()
        label.frame = CGRectMake(0, -20 - labelHight, UIScreen.mainScreen().bounds.width , labelHight)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(16)
        label.textAlignment = NSTextAlignment.Center
        
        self.navigationController?.navigationBar.insertSubview(label, atIndex: 0)
        
        return label
        
    }()
    
    //MARK: - 加载网络数据
    @objc private func loadStatus() {
        
        var since_id = statuses.first?.id ?? 0
        var max_id = 0
        
        if pullUpView.isAnimating()
        {
            since_id = 0
            max_id = (statuses.last?.id)! ?? 0
        }
      
        //[weak self]: 显示列表；表示闭包里面的self都是weak引用的
        GDStatus.loadStatus(since_id, max_id: max_id) {[weak self](statuses, error) -> () in
            
            //加载完数据后停止菊花
            self!.refreshControl?.endRefreshing()
            //停止上拉菊花
            self?.pullUpView.stopAnimating()
            
            //加载数据失败
            if error != nil
            {
                print("加载微博数据失败error:\(error)")
                
                SVProgressHUD.showErrorWithStatus("加载微博数据失败", maskType: SVProgressHUDMaskType.Black)
                return
            }
            
//            if statuses == nil || statuses?.count == 0
//            {
//                SVProgressHUD.showInfoWithStatus("没有新的微博", maskType: SVProgressHUDMaskType.Black)
//                return
//            }
            
            let count = statuses?.count ?? 0
            print("加载:\(count)条微博")
            
            if since_id > 0
            {
                //有微博数据
                self!.statuses = statuses! + (self?.statuses)!
                //调用刷新方法提示加载了多少条微博
                self!.showPullDownTip(count)
                
            }
            else if max_id > 0 {
                //加载更多数据
                self?.statuses = (self?.statuses)! + statuses!
                
            }else
            {
                //否则还是等于当前的微博数据
                self?.statuses = statuses!
                
            }
            print("现在有\(self!.statuses.count)条微博")
        }
        
    }
    
    //MARK: - 数据源方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //返回行数
        return statuses.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let status = statuses[indexPath.row]
        
        //创建cell
        let cell = tableView.dequeueReusableCellWithIdentifier(status.cellId(), forIndexPath: indexPath) as! GDStatusCell
        
        //为cell赋值
//        cell.textLabel!.text = statuses[indexPath.row].text
        // 设置cell的微博模型
        cell.status = status
        
        
        //判断单前的cell是否为最后一行
        if indexPath.row == statuses.count - 1 && !pullUpView.isAnimating()
        {
            //开启菊花
            pullUpView.startAnimating()
            //加载更多数据
            loadStatus()
            
        }
        
        return cell
    }

    //返回每个cell的高度
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //获取status
        let status = statuses[indexPath.row]

        //有属性直接返回
        if let rowHeight = status.rowHeight {
         
            return rowHeight
        }
        
        //获取cell
        let cell = tableView.dequeueReusableCellWithIdentifier(status.cellId()) as! GDStatusCell
        //计算并获得行高
        let rowHeight = cell.rowHeight(status)
        //将行高设置给模型属性
        status.rowHeight = rowHeight
        
        return rowHeight
        
    }
    
    
    
    
    //MARK: - 设置导航控制器
    //设置导航栏
    func setNavgationBar() {
        
        //添加左边item
//        let leftBtn = UIButton()
//        leftBtn.setBackgroundImage(UIImage(named: "navigationbar_friendsearch"), forState: UIControlState.Normal)
//        leftBtn.setBackgroundImage(UIImage(named: "navigationbar_friendsearch_highlighted"), forState: UIControlState.Highlighted)
//        leftBtn.sizeToFit()
//        navigationItem.leftBarButtonItem = creatBarButtonItem("navigationbar_friendsearch", highlightImageName: "navigationbar_friendsearch_highlighted")
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch")
        
        
        //添加右边item
//        let rightBtn = UIButton()
//        rightBtn.setBackgroundImage(UIImage(named: "navigationbar_pop"), forState: UIControlState.Normal)
//        rightBtn.setBackgroundImage(UIImage(named: "navigationbar_pop_highlighted"), forState: UIControlState.Highlighted)
//        rightBtn.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        
        //设置中间的按钮
        let name = GDUserAccount.loadAccount()?.name ?? "没有名称"
        let btn = GDHomeTitleButton(title: name)
        //为按钮添加点击事件
        btn.addTarget(self, action: "homeTitleClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //将按钮添加到文本view中
        navigationItem.titleView = btn
        
        
    }
    
    //MARK： - 监听titleBtn的点击事件
    //OC方法可以调用swift的私有方法
     @objc private func homeTitleClick(btn: UIButton) {
        
        //切换按钮的选择属性
        btn.selected = !btn.selected
        
        //创建旋转属性
        var transform: CGAffineTransform = CGAffineTransformIdentity
        
        if btn.selected {
            //旋转180 - 0.01，保证能逆时针回到原位置
            transform = CGAffineTransformMakeRotation(CGFloat(M_PI) - 0.01)
        }else
        {
            //回到原位置
            transform = CGAffineTransformIdentity
        }
        
        //动画执行
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            btn.imageView?.transform = transform
            
        })
        
    }

    
//   private func creatBarButtonItem(imageName: String, highlightImageName:String) -> UIBarButtonItem
//    {
//        let Btn = UIButton()
//        Btn.setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
//        Btn.setBackgroundImage(UIImage(named: highlightImageName), forState: UIControlState.Highlighted)
//        Btn.sizeToFit()
// 
//        return UIBarButtonItem(customView: Btn)
//    }
//    
    
    
    
}
