//
//  AttendanceMonthStatistics.swift
//  Attendance
//
//  Created by 胡舒琦 on 2017/1/14.
//  Copyright © 2017年 胡舒琦. All rights reserved.
//

import Foundation
import RxSwift

public struct Result {
    var apollo:String
    var userJson:String
    
    init(apollo:String, userJSON:String) {
        self.apollo = apollo
        self.userJson = userJSON
    }
}

open class Attendance {
    
    /// 获取用户权限字符串
    ///
    /// - Parameter userId: 用户账号
    @discardableResult open func regiest(_ userId:Variable<String>)  -> Observable<Result> {
        return Observable<Result>.create({ (observable) -> Disposable in
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
                    NETWORK.Apollo = apollo
                    NETWORK.UserJSON = userJson
                    observable.onNext(Result(apollo: apollo!,userJSON: userJson!))
                    observable.onCompleted()
                }
            }.error { (error) in
                observable.onError(error)
            }
            
            return Disposables.create()
        })
    }
}
