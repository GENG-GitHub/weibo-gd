
//
//  GDUser.swift
//  GDWeibo
//
//  Created by geng on 15/11/3.
//  Copyright © 2015年 geng. All rights reserved.
//

import UIKit

class GDUser: NSObject {

    
    /// 字符串型的用户UID
    var idstr: String?
    
    /// 友好显示名称
    var name: String?
    
    /// 用户头像地址（中图），50×50像素
    var profile_image_url: String?
    
    /// 返回头像对应的NSURL对象,有可能没有值
    var profileImageUrl: NSURL? {
        if let urlString = profile_image_url {
            return NSURL(string: urlString)
        }
        
        return nil
    }
    
    /// verified_type 没有认证:-1   认证用户:0  企业认证:2,3,5  达人:220
    var verified_type: Int = -1
    
    var verifiedTypeImage: UIImage? {
        switch verified_type {
        case 0:
            return UIImage(named: "avatar_vip")
        case 2,3,5:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
        default:
            return nil
        }
    }
    
    /// 会员等级 1-6
    var mbrank: Int = 0
    
    // 计算型属性,根据不同会员等级返回不同的图片
    var mbrankImage: UIImage? {
        if mbrank > 0 && mbrank <= 6 {
            return UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        return nil
    }

    
    //MARK: - 构造方法
    init(dict: [String: AnyObject]) {
    
        super.init()
        setValuesForKeysWithDictionary(dict)
    
    }
    
    //字典中的key没有对应的属性
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    //打印对象
    override var description: String {
        let properties = ["id", "name", "profile_image_url", "verified_type", "mbrank"]
        return "\n\t\t:用户模型:\(dictionaryWithValuesForKeys(properties))\n"
    }
    
    
    
    
    
    
    
    
    
}
