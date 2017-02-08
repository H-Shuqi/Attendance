//
//  Error.swift
//  Attendance
//
//  Created by 胡舒琦 on 2017/2/8.
//  Copyright © 2017年 胡舒琦. All rights reserved.
//

import Foundation

public class HError : Error {
    public var description:String
    public var code:Int
    public var localizedDescription:String {
        get{
            return "Error :\(description) Code :\(code)"
        }
    }
    
    init(_ code:Int, _ description:String) {
        self.code = code
        self.description = description
    }
}
