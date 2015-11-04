//
//  GDStatus.swift
//  GDWeibo
//
//  Created by geng on 15/11/3.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDStatus: NSObject {
    
    
    /// 微博创建时间
    var created_at: String?
    
    /// 字符串型的微博ID
    var idstr: String?
    
    /// 微博信息内容
    var text: String?
    
    /// 微博来源
    var source: String?
    
    /// 微博的配图
    var pic_urls: [[String: AnyObject]]?
    
    //用户模型
    var user: GDUser?
    
    
    //字典转模型
    init(dict: [String : AnyObject]) {
        
        super.init()
        //KVC赋值属性
        setValuesForKeysWithDictionary(dict)
    }
    
    
    //重写setValuesForKeysWithDictionary方法
    override func setValue(value: AnyObject?, forKey key: String)
    {
        
        //判断当key为user时
        if key == "user"
        {
            if let dict = value as? [String: AnyObject] {
                user = GDUser(dict: dict)
                return
            }
        }
        super.setValue(value, forKey: key)
    }

    
    
    
    //字典的key在模型中找不到的key
    override func setValue(value: AnyObject?, forUndefinedKey key: String) { }
    
    //打印数据
    override var description: String
    {
        let p = ["created_at", "idstr", "text", "source", "pic_urls", "user"]
        // 数组里面的每个元素,找到对应的value,拼接成字典
        return "\n\t微博模型:\(dictionaryWithValuesForKeys(p))"
    }
    
    
    //MARK: - 加载微博数据
    class func loadStatus(finished: (statuses: [GDStatus]?, error: NSError?) -> ())
    {
        GDNetworkTools.sharedNetworkTool.loadStatus { (result, error) -> () in

            //数据请求失败
            if error != nil
            {
                print("error:\(error)")
                //通知调用者
                finished(statuses: nil, error: error)
                return
            }
           
            //result为一个字典，它的里面有一个数组，数组由多个字典组成
            if let array = result?["statuses"] as? [[String: AnyObject]] {
                
                //创建模型数组
                var statuses = [GDStatus]()
                
                for dict in array
                {
                    statuses.append(GDStatus(dict: dict))
                }
                //返回数据
                finished(statuses: statuses, error: nil)
                
            }else{
            //没有返回数据
                finished(statuses: nil, error: nil)
            }
            
        }
        
    }
    
    

}

