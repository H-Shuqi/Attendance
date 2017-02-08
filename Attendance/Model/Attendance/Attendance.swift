//
//  AttendanceMonthStatistics.swift
//  Attendance
//
//  Created by 胡舒琦 on 2017/1/14.
//  Copyright © 2017年 胡舒琦. All rights reserved.
//

import Foundation

open class Attendance {
    public typealias ErrorHandler = (Error!) -> Swift.Void
    public typealias ProgressHandler = (Progress!) -> Void
    private var progressHandler: ProgressHandler?
    private var errorHandler: ErrorHandler?

    @discardableResult open func error(errorHandler:@escaping ErrorHandler) -> Attendance {
        self.errorHandler = errorHandler
        return self
    }
    
    @discardableResult open func progress(progressHandler:@escaping ProgressHandler) -> Attendance {
        self.progressHandler = progressHandler
        return self
    }
    
    /// 获取用户权限字符串
    ///
    /// - Parameter userId: 用户账号
    @discardableResult open func acquireCountable(_ userId:String, com:@escaping (String,String)->Void)  -> Attendance {
        HTTPRequest(NETWORK.COUNTABLE).cookies([
            NETWORK.CHECK_USER:userId
        ]).parameters([
            "state":"corpId=wxdd81efc4e5de91c9,appId=5,whichPage=gotoRecord"
        ]).response { (response) in
            let apollo = response.cookies["SESSION_USER_INFO_APOLLO"]
            let userJson = response.cookies["SESSION_USER_INFO_JSON"]
            NETWORK.Apollo = apollo
            NETWORK.UserJSON = userJson
            com(apollo!,userJson!)
        }.progress({ (progress) in
            print("请求进度: \(progress?.completedUnitCount)")
        }).error { (error) in
            if self.errorHandler != nil {
                self.errorHandler!(error)
            }
        }
        return self
    }
}
