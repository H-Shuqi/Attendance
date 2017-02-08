//
//  StartViewController.swift
//  Attendance
//
//  Created by 胡舒琦 on 2017/1/18.
//  Copyright © 2017年 胡舒琦. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import pop
import RxSwift
import RxCocoa

class StartViewController : UIViewController, UITextFieldDelegate {
    private let viewModel:StartViewModel = StartViewModel()
    
    let tfUserID:UITextField = UITextField()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        self.view.addSubview(tfUserID)
        tfUserID.textAlignment = .center
        tfUserID.tintColor = UIColor.lightGray
        tfUserID.returnKeyType = .join
        tfUserID.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
        }

        tfUserID.rx.text.orEmpty.bindTo(viewModel.vbUserID).addDisposableTo(disposeBag)
        //tfUserID.delegate = self
        tfUserID.rx.controlEvent(.editingDidEndOnExit).flatMap {
            self.viewModel.obUserLogin
        }.subscribe(onError: { (error) in
            print(error)
        }, onCompleted: {
            print("成功")
        }).addDisposableTo(disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        tfUserID.layer.borderColor = UIColor.lightGray.cgColor
        tfUserID.layer.borderWidth = 1//UIScreen.main.scale/2
        tfUserID.layer.cornerRadius = 6
    }
    
}
