//
//  GDNetworkTools.swift
//  GDWeibo
//
//  Created by geng on 15/10/30.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit
import AFNetworking


//定义错误枚举
enum GDNetworkError: Int {
    
    case emptyToken = -1
    case emptyUid = -2
    
    //枚举中定义属性
    var description: String {
       
        get {
            switch self {
            case GDNetworkError.emptyToken:
                return "access Token为空"
            case GDNetworkError.emptyUid:
                return "uid为空"
            }
        }
    }
    
    //枚举中定义方法
    func error() -> NSError? {
        
        return NSError(domain: "com.baidu.error.network", code: rawValue, userInfo: ["errorDescription":description])
        
    }

}









class GDNetworkTools: NSObject {

    
    //属性
    private var afnManager: AFHTTPSessionManager
    
    // 创建单例
    static let sharedNetworkTool: GDNetworkTools = GDNetworkTools()
    
    override init() {
        let urlString = "https://api.weibo.com/"
        afnManager = AFHTTPSessionManager(baseURL: NSURL(string: urlString))
        afnManager.responseSerializer.acceptableContentTypes?.insert("text/plain")
    }

//    static let sharedNetworkTool: GDNetworkTools = {
//        
//        //设置基本的url
//        let urlString = "https://api.weibo.com/"
//        let tool = GDNetworkTools(baseURL: NSURL(string: urlString))
//        //设置解析的方式
//        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
//        
//        return tool
//        
//    }()
//    
    
    //APP Key
    private let client_id = "1813572641"
    
    //APP secret
    private let client_secret = "a70724e8e5c91f8805f5f51aaa0cfc37"
    
    /// 请求的类型，填写authorization_code
    private let grant_type = "authorization_code"
    
    //回调地址
    let redirect_uri = "http://www.baidu.com/"
    
    
    // OAtuhURL地址
    func oauthRUL() -> NSURL {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)"
        return NSURL(string: urlString)!
    }
    
    
    //使用闭包回调
    //MARK: - 加载AccessToken
    func loadAccessToken(code: String, finshed: (result: [String: AnyObject]?, error: NSError?) -> ()) {
        //url
        let urlString = "oauth2/access_token"
        
        
        //设置请求参数
        let parameters = [
            
            "client_id": client_id,
            "client_secret": client_secret,
            "grant_type": grant_type,
            "code": code,
            "redirect_uri": redirect_uri
            
        ]
        //测试返回结果类型  
//        afnManager.POST(urlString, parameters: parameters, success: { (_, result) -> Void in
//
//            //请求成功
//            finshed(result: result as? [String: AnyObject], error: nil)
//            
//            }) { (_, error: NSError) -> Void in
//                
//                //请求失败
//                finshed(result: nil, error: error)
//        }
        
        requestPOST(urlString, parameters: parameters, finshed: finshed)
        
        
    }
    
    
    //MARK: - 加载用户信息
    func loadUserInfo(finished: NetworkFinishedCallback)
    {
//        //判断是否有accessToken
//        if GDUserAccount.loadAccount()?.access_token == nil
//        {
//            print("没有找到accessToken")
//            
//            finished(result: nil, error: GDNetworkError.emptyToken.error())
//            
//            return
//        }
        
        guard var parameters = tokenDict(finished) else {
            print("没有 token")
            return
        }
        
        //判断uid
        if GDUserAccount.loadAccount()?.uid == nil
        {
            print("没有找到uid")
            finished(result: nil, error: GDNetworkError.emptyUid.error())
            
            return
        }
        
        //创建url
        let urlStr = "2/users/show.json"
        

        //设置请求参数
//        let parameters = [
//            
//            "access_token": GDUserAccount.loadAccount()!.access_token!,
//            "uid": GDUserAccount.loadAccount()!.uid!,
////            "source" : "1813572641"
//        ]
        
        parameters["uid"] = GDUserAccount.loadAccount()!.uid!
        
        
        requestGET(urlStr, parameters: parameters, finshed: finished)
        
//        //GET请求
//        afnManager.GET(urlStr, parameters: parameters, success: { (_, result) -> Void in
//            
//            finished(result: result as? [String : AnyObject], error: nil)
//            print("toolResult:\(result)")
//            
//            
//            }) { (_, error) -> Void in
//                
//                finished(result: nil, error: error)
//                print("toolerror:\(error)")
//        }
        

    }
    
    
    
    //MARK: - 获取微博数据
    func loadStatus(finished:NetworkFinishedCallback)
    {
        
        guard let parameters = tokenDict(finished) else{
            
            return
        }
        //https://api.weibo.com/2/statuses/home_timeline.json?access_token=2.002K76cCdFZjyBf2cc03a5b4089Cbw
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        //get请求
        requestGET(urlString, parameters: parameters, finshed: finished)
    }
    
    
    
    //返回值为token的字典
    func tokenDict(finished: NetworkFinishedCallback) -> [String: AnyObject]?
    {
        //当access为空
        if GDUserAccount.loadAccount()?.access_token == nil
        {
            finished(result: nil, error: GDNetworkError.emptyToken.error())
            return nil
        }
        
        return ["access_token" :GDUserAccount.loadAccount()!.access_token!]
    }
    
    
    
    
    
    // 类型别名 = typedefined
    typealias NetworkFinishedCallback = (result: [String: AnyObject]?, error: NSError?) -> ()
    
    // MARK: - 封装AFN.GET
    private func requestGET(URLString: String, parameters: AnyObject?, finshed: NetworkFinishedCallback) {
        
        afnManager.GET(URLString, parameters: parameters, success: { (_, result) -> Void in
            
            finshed(result: result as? [String: AnyObject], error: nil)
            
            }) { (_, error) -> Void in
                
                finshed(result: nil, error: error)
        }
        
    }
    
    private func requestPOST(URLString: String, parameters: AnyObject?, finshed: NetworkFinishedCallback)
    {
        //测试返回结果类型
        afnManager.POST(URLString, parameters: parameters, success: { (_, result) -> Void in
            
            //请求成功
            finshed(result: result as? [String: AnyObject], error: nil)
            
            }) { (_, error: NSError) -> Void in
                
                //请求失败
                finshed(result: nil, error: error)
        }
        
    }
}