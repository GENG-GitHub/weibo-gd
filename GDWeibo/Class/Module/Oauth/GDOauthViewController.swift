//
//  GDOauthViewController.swift
//  GDWeibo
//
//  Created by geng on 15/10/30.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit
import SVProgressHUD

class GDOauthViewController: UIViewController {

    //懒加载网页视图
    private lazy var webView = UIWebView()
    
    override func loadView() {
        
        view = webView
        
        //设置代理
        webView.delegate = self
        
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置导航控制器的取消按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        
        
        let request = NSURLRequest(URL:GDNetworkTools.sharedNetworkTool.oauthRUL())
        webView.loadRequest(request)
        
    }


    //关闭网页登陆控制器
    func close() {
        
        SVProgressHUD.dismiss()
        //退出当前控制器
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}



//MARK: - 扩展 CZOauthViewController
extension GDOauthViewController: UIWebViewDelegate {
    
    
    //web开始加载
    func webViewDidStartLoad(webView: UIWebView) {
        //显示正在下载
        
        /*
        case None // allow user interactions while HUD is displayed
        case Clear // don't allow user interactions
        case Black // don't allow user interactions and dim the UI in the back of the HUD
        case Gradient
        */
        SVProgressHUD.showWithStatus("玩命加载中...", maskType: SVProgressHUDMaskType.Black)
     
    }
    
    //加载完毕之后关闭当前页面
    func webViewDidFinishLoad(webView: UIWebView) {
        //关闭
        SVProgressHUD.dismiss()
    }
    
    
    //询问是否加载
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        
        let urlString = request.URL!.absoluteString
        
        /*
        urlString: https://api.weibo.com/oauth2/authorize?client_id=1813572641&redirect_uri=http://www.baidu.com/
        urlString: https://api.weibo.com/oauth2/authorize
        urlString: https://api.weibo.com/oauth2/authorize#
        urlString: https://api.weibo.com/oauth2/authorize
        urlString: http://www.baidu.com/?code=074837eec9971dec6d4d9d26ad2318e1
        */
//        print("urlString: \(urlString)")
        
        
        // 加载的不是回调地址
        
        if !urlString.hasPrefix(GDNetworkTools.sharedNetworkTool.redirect_uri)
        {
            return true //可以加载
        }
        
        //如果点击的是确定或取消按钮时拦截不加载,获得访问的数据
        if let query = request.URL!.query{
            
            //query:code=074837eec9971dec6d4d9d26ad2318e1
            print("query:\(query)")
            
            let codeString = "code="
            
            //判断是否有前缀“code=”
            if query.hasPrefix(codeString)
            {
                //转成NSString
                let nsQuery = query as NSString
                
                /*
                code: 074837eec9971dec6d4d9d26ad2318e1
                */
                
                //截取code的值
                let code = nsQuery.substringFromIndex(codeString.characters.count)
                print("code: \(code)")
                
                //获得access Token
                 loadAccessToken(code)
                
            }else {
        
                //取消
                close()
                
            }
    
            
        }

        return false
    }
    
    //调用网路工具类去加载access token
    
    func loadAccessToken(code: String) {
        
        GDNetworkTools.sharedNetworkTool.loadAccessToken(code) { (result, error) -> () in
            
            if error != nil || result == nil
            {
                print("error: \(error)")
                
                //显示网络加载失败
                self.netError("网络不给力...")
                return
            }
            /*
            
            result:Optional([
            "access_token": 2.002K76cCdFZjyB0bec9695ed0uSghd,
            "remind_in": 157679999, 
            "uid": 2399825217, 
            "expires_in": 157679999])
            
            */
        
            //获得请求结果
            print("result:\(result)")
            
           let account =  GDUserAccount(dict: result!)
            
            //保存数据到沙盒
            account.saveAccount()
            
            print("account1:\(account)")
            
            //加载数据
            account.loadUserInfo({ (error) -> () in
                
                if error != nil
                {
                    self.netError("加载用户信息失败")
                    
                    return
                }
                
                print("account2:\(account)")
                self.close()
                
            })

            SVProgressHUD.dismiss()
            
        }
  
    }
    
    
    private func netError(message: String) {
        SVProgressHUD.showErrorWithStatus(message, maskType: SVProgressHUDMaskType.Black)
        
        // 延迟关闭. dispatch_after 没有提示,可以拖oc的dispatch_after来修改
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
            self.close()
        })
    }
    
    
}










