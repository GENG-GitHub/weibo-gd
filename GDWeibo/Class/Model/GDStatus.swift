//
//  GDStatus.swift
//  GDWeibo
//
//  Created by geng on 15/11/3.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit
import SDWebImage

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
    var pic_urls: [[String: AnyObject]]? {
        
        didSet {
         
            //判断pic_urls是否有值
            if pic_urls?.count == 0 {
                
                return
            }
            
            storePictureURLs = [NSURL]()
            
            //遍历数组存储url
            for dict in pic_urls! {
                let value = dict["thumbnail_pic"] as! String
                //将图片的url存入pictureURLs中
                storePictureURLs?.append(NSURL(string: value)!)
                
            }
        }
        
    }
    
    //用户模型
    var user: GDUser?
    
    //存储pic_urls中的NSURL
    var storePictureURLs: [NSURL]?
    //根据转发微博属性是否有值，返回对应的微博
    var pictureURLs: [NSURL]? {
        
        get {
            
            return retweeted_status == nil ? storePictureURLs : retweeted_status?.storePictureURLs
        }
    
    }
    
    //用于缓存cell的行高
    var rowHeight: CGFloat?
    
    /// 被转发微博
    var retweeted_status: GDStatus?
    
     /// 返回原创微博或者转发微博cell的ID
     func cellId() -> String{
        
        return retweeted_status == nil ? GDStatusCellIndentifier.NormalCell.rawValue : GDStatusCellIndentifier.ForwardCell.rawValue
        
    }
    
    
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
        
        if key == "retweeted_status"
        {
            if let dict = value as? [String: AnyObject]
            {
                retweeted_status = GDStatus(dict: dict)
                return
            }
        }
        
        
        
        return super.setValue(value, forKey: key)
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
//                finished(statuses: statuses, error: nil)
                //调用图片缓存方法并返回数据
                self.cacheWebImage(statuses, finished: finished)
                
            }else{
            //没有返回数据
                finished(statuses: nil, error: nil)
            }
            
        }
        
    }
    
    
    //缓存图片
    class func cacheWebImage(statuses: [GDStatus]?, finished: (statuses: [GDStatus]? ,error: NSError?) -> ())
    {
        
        //定义任务组
        let group = dispatch_group_create()
        
        //记录下载图片的大小
        var length = 0
        
        //判断是否有模型
        guard let list = statuses else
        {
            //没有模型
            return
        }
 
        //遍历模型数组
        for status in list {
            
            
            guard let urls = status.pictureURLs else
            {
                //当前模型没有数据，则直接遍历下一个模型
                continue
            }
            
            //            //遍历图片数组，获得每一个需要下载的url
            //            for url in urls {

            if urls.count == 1
            {
                let url = urls[0]
                
                //进入任务组
                dispatch_group_enter(group)
                
                //缓存图片
                SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (image, error, _, _, _) -> Void in
                    
                    dispatch_group_leave(group)
                    
                    //离开任务组
                    if error != nil
                    {
                        print("下载图片出错")
                        finished(statuses: list, error: error)
                        return
                    }
                    
                    //下载图片没有出错
                    print("下载完成: \(url)）")
                    
                    //获取下载图片的大小
                    if let data = UIImagePNGRepresentation(image) {
                        
                        length += data.length
                    }
                    
                })
  
            }
            
        }
        //下载完成所有图片才通知调用者微博数据加载完成
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            
            print("下载图片完成:\(length / 1024) K")
            
            finished(statuses: list, error: nil)
        }
    }
}




