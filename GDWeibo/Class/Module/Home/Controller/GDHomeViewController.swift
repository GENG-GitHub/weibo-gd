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
        
        //注册cell
        tableView.registerClass(GDStatusNormaCell.self, forCellReuseIdentifier: GDStatusCellIndentifier.NormalCell.rawValue)
        tableView.registerClass(GDStatusForwardCell.self, forCellReuseIdentifier: GDStatusCellIndentifier.ForwardCell.rawValue)
        
//        tableView.rowHeight = 100

        //预设行高
        tableView.estimatedRowHeight = 300
        //设置自动行高
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // 去掉分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        //设置导航控制器
        setNavgationBar()
        //加载微博数据
        loadStatus()
        
    }
    
    
    //获取微博数据
    private var statuses = [GDStatus]() {
        
        didSet{
            //每次赋值时都刷新数据
            tableView.reloadData()
        }
    }
    
    //MARK: - 加载网络数据
    private func loadStatus() {
      
        //[weak self]: 显示列表；表示闭包里面的self都是weak引用的
        GDStatus.loadStatus {[weak self](statuses, error) -> () in
            
            //加载数据失败
            if error != nil
            {
                print("加载微博数据失败error:\(error)")
                
                SVProgressHUD.showErrorWithStatus("加载微博数据失败", maskType: SVProgressHUDMaskType.Black)
                return
            }
            
            if statuses == nil || statuses?.count == 0
            {
                SVProgressHUD.showInfoWithStatus("没有新的微博", maskType: SVProgressHUDMaskType.Black)
                return
            }
            //有微博数据
            self!.statuses = statuses!
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
