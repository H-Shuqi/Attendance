//
//  AttendanceMonthStatistics.swift
//  Attendance
//
//  Created by 胡舒琦 on 2017/1/14.
//  Copyright © 2017年 胡舒琦. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

open class Attendance {
    
    /// 获取用户权限字符串
    ///
    /// - Parameter userId: 用户账号
    open func regiest(_ userId:Variable<String>)  -> Observable<LimitResult> {
        return Observable<LimitResult>.create({ (observable) -> Disposable in
            HTTPRequest(NETWORK.COUNTABLE).cookies([
                NETWORK.CHECK_USER:userId.value
            ]).parameters([
                "state":"corpId=wxdd81efc4e5de91c9,appId=5,whichPage=gotoRecord"
            ]).response { (response) in
                let apollo = response.cookies["SESSION_USER_INFO_APOLLO"]
                let userJson = response.cookies["SESSION_USER_INFO_JSON"]
                if apollo == nil || userJson == nil {
                    observable.onError(HError(-10, "数据为空"))
                }else{
                    User.sharedInstance.userId = userId.value
                    User.sharedInstance.save()
                    NETWORK.Apollo = apollo
                    NETWORK.UserJSON = userJson
                    observable.onNext(LimitResult(apollo: apollo!,userJSON: userJson!))
                    observable.onCompleted()
                }
            }.error { (error) in
                observable.onError(error)
            }
            
            return Disposables.create()
        })
    }
    
    
    /// 获取考勤统计信息及用户绑定ID
    ///
    /// - Returns: JSON
    open func monthStatistics(data:String) -> Observable<JSON> {
        return Observable<JSON>.create({ (observable) -> Disposable in
            HTTPRequest(NETWORK.MONTH_STATISTICS).cookies([
                "SESSION_USER_INFO_APOLLO":NETWORK.Apollo,
                "SESSION_USER_INFO_JSON":NETWORK.UserJSON,
                NETWORK.CHECK_USER:User.sharedInstance.userId!
            ]).parameters([
                "data":data
            ]).response { (response) in
                if(response.jsonData != nil){
                    if (response.jsonData!["success"].boolValue) {
                        observable.onNext(response.jsonData!)
                        observable.onCompleted()
                    }else{
                        observable.onError(HError(-9, response.jsonData!["msg"].stringValue))
                    }
                }else{
                    observable.onError(HError(-10, "数据为空"))
                }
            }.error { (error) in
                observable.onError(error)
            }
            return Disposables.create()
        })
    }
}
