//
//  StartViewModel.swift
//  Attendance
//
//  Created by 胡舒琦 on 2017/1/19.
//  Copyright © 2017年 胡舒琦. All rights reserved.
//

import Foundation
import RxSwift

class StartViewModel {
    
    public var userID:Variable<String> = Variable("")
    
    init() {
        userID.asObservable().subscribe(onNext: { (text) in
            print(text)
        }).addDisposableTo(DisposeBag())
        ///
    }
    
}
