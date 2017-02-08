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
    
    private let disposeBag = DisposeBag()
    public let vbUserID:Variable<String> = Variable("")
    public var obUserLogin:Observable<Void>!
    
    init(){
        obUserLogin = Attendance().regiest(self.vbUserID.value)
    }

}
