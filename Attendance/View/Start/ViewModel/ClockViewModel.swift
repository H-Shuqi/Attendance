//
//  ClockViewModel.swift
//  Attendance
//
//  Created by 胡舒琦 on 17/2/9.
//  Copyright © 2017年 胡舒琦. All rights reserved.
//

import Foundation
import RxSwift

class ClockViewModel {
    private var timer:Timer!
    var showTime:Variable<String> = Variable<String>("")
    var dateDescription:Variable<String> = Variable<String>("")
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ClockViewModel.timerCall(timer:)), userInfo: nil, repeats: true)
        dateDescription.value = dateDescriptionFormat()
    }
    
    @objc func timerCall(timer:Timer) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        showTime.value = formatter.string(from: date)
    }
    
    func dateDescriptionFormat() -> String {
        let weakArr = ["一","二","三","四","五","六","日"]
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "M月d日"
        let dateStr = formatter.string(from: date)
        formatter.dateFormat = "w"
        let weakStr = weakArr[(Int)(formatter.string(from: date))!]
        formatter.dateFormat = "a"
        let apmStr = formatter.string(from: date)
        formatter.dateFormat = "hh:mm"
        let timeStr = formatter.string(from: date)
        formatter.weekdaySymbols = []
        
        return "\(dateStr) 周\(weakStr) \(apmStr)\(timeStr)"
    }
}
