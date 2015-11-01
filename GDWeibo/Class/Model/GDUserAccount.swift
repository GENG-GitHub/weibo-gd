//
//  GDUserAccount.swift
//  GDWeibo
//
//  Created by geng on 15/10/31.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDUserAccount: NSObject ,NSCoding{
    
    
//    result:Optional([
//    "access_token": 2.002K76cCdFZjyB0bec9695ed0uSghd,
//    "remind_in": 157679999,
//    "uid": 2399825217,
//    "expires_in": 157679999])
    
    //接口获取授权后的access_token
    var access_token: String?
    
    //access_token的生命周期，单位是秒数
    var expires_in: NSTimeInterval = 0 {
        
        didSet {
            //将时间戳转化为日期
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
            //print("expires_date:\(expires_date)")
        }
        
    }
    
    //access_token生命截止时间
    var expires_date: NSDate?
    
    //当前授权用户的UID
    var uid: String?

    
    //友好显示名称
    var name: String?
    
    //用户头像地址（大图），180×180像素
    var avatar_large: String?
    
    
    //KVC 字典转模型
    init (dict:[String: AnyObject]) {
        
        super.init()
        
        //将字典里面的的每一个key的值赋值给对应的模型属性
        setValuesForKeysWithDictionary(dict)
    }
    
    //模型属性中没有对应上字典中的key时，重写该方法，可以避免报错
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        print("UndefinedKey:\(key)")
    }
    
    //重写字符串打印的方法
    override var description: String {
    
        return "access_token:\(access_token), expires_in:\(expires_in), uid:\(uid): expires_date:\(expires_date),name:\(name): avatar_large:\(avatar_large)"
    }
    
    
    //拼接沙盒文件路径
    static let accountPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! + "/Account.plist"
    
    
    //MARK： - 加载用户信息
    //对加载用户信息后的结果成功或失败进行返回
    func loadUserInfo(finised:(error: NSError?) -> ())
    {
        GDNetworkTools.sharedNetworkTool.loadUserInfo { (result, error) -> () in
            //加载失败
            if error != nil && result == nil
            {
                finised(error: error)
                return
            }
            
            //加载成功
            self.name = result!["name"] as? String
            self.avatar_large = result!["avatar_large"] as? String
            
            //保存到沙盒
            self.saveAccount()
            
            //同步到内存中，把当前对象赋值给内存的中的userAccount
            GDUserAccount.userAccount = self
            
            finised(error: nil)
            
        }
        
        
    }
    
    
    
    
    //MARK: - 保存对象
    func saveAccount() {
        NSKeyedArchiver.archiveRootObject(self, toFile: GDUserAccount.accountPath)
    }
    
    //定义一个全局的静态变量，第一次从沙盒中加载账号之后，就保存在内存之中，避免每次都去沙盒获取数据
    private static var userAccount: GDUserAccount?
    
    //MARK: - 加载对象
    class func loadAccount() -> GDUserAccount? {
        
        
//        print("NSHomeDirectory()\(NSHomeDirectory())")
        
        
        //如果内存中没有账号的时候，则从沙盒中加载
        if(userAccount == nil)
        {
            //从沙盒中获取数据
            userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? GDUserAccount
        }
        
        //再次判断内存中是否有数据，且数据未过期
        if(userAccount != nil && userAccount?.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedDescending)
        {
            print("账号有效")
            return userAccount
            
        }
        
        
        return nil
        
    }
    
    
    //归档和解档
    required init?(coder aDecoder: NSCoder) {
        
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        name = aDecoder.decodeObjectForKey("name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
    
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
    }
    
    

}
