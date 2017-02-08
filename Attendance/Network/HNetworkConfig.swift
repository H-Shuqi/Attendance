//
//  HNetworkConfig.swift
//  Component
//
//  Created by 胡舒琦 on 16/11/17.
//  Copyright © 2016年 胡舒琦. All rights reserved.
//

import Foundation

public struct NETWORK {
    
    /// 权限验证字符串
    public static var Apollo:String!
    public static var UserJSON:String!
    public static let APP_ID = "wxdd81efc4e5de91c9"
    public static var CHECK_USER:String {
        get {
            return "COOKIE_WX_USER_ID_"+APP_ID
        }
    }
    
    /// 服务器地址
    public static let SERVER_ADDRESS = "http://w.21cn.com"
    
    /// GET 获取权限
    public static let COUNTABLE = "/apollo/forward/initPage.do"
    
    /// GET 初始化权限
    public static let INIT_COUNTABLE = "/apollo/forward/gotoPage.do";
    
    /// POST 获取统计
    public static let MONTH_STATISTICS = "/apollo/attendance/getMonthStatistics.do"
    
    /// POST 获取月记录
    public static let MONTH_RECORD = "/apollo/attendance/getMonthRecord.do"
    
    /// POST 获取部门考勤
    public static let DEPARTMENT_DAY_DETAILS = "/apollo/attendance/getDepartmentDayDetails.do"
    
    /// POST 获取考勤详情
    public static let MONTH_DETAILS = "/apollo/attendance/getMonthDetails.do"

    /// GET 获取用户头像
    public static let PERSONAL_IMAGE = "/apollo/get/getPersonalImg.do"
    
    /// POST 打卡
    public static let ATTENDANCE_SIGN = "/apollo/attendance/sign.do"
    
}

