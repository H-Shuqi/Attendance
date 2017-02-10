//
//  Models.swift
//  Attendance
//
//  Created by 胡舒琦 on 17/2/9.
//  Copyright © 2017年 胡舒琦. All rights reserved.
//

import Foundation


/// 用户实例
public struct User {
    public static var sharedInstance:User = User()
    public var userId:String?
    public var bindId:String?
    
    private init(_ userId:String?, _ bindId:String?) {
        self.userId = userId
        self.bindId = bindId
    }
    
    private init(){
        let userId = UserDefaults.standard.string(forKey: "userId")
        let bindId = UserDefaults.standard.string(forKey: "bindId")
        self.init(userId, bindId)
    }
    
    func save() {
        if self.userId != nil {
            UserDefaults.standard.set(self.userId, forKey: "userId")
        }
        
        if self.bindId != nil {
            UserDefaults.standard.set(self.bindId, forKey: "bindId")
        }
    }
}

/// 权限字符串返回对象
public struct LimitResult {
    var apollo:String
    var userJson:String
    
    init(apollo:String, userJSON:String) {
        self.apollo = apollo
        self.userJson = userJSON
    }
}
