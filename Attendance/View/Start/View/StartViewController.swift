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

class StartViewController : UIViewController {
    let viewModel:StartViewModel = StartViewModel()
    
    let btnInteraction:UIButton = UIButton()
    let tfUserID:UITextField = UITextField()

    override func viewDidLoad() {
        self.view.addSubview(tfUserID)
        tfUserID.textAlignment = .center
        tfUserID.tintColor = UIColor.lightGray
        tfUserID.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
        }
        
        self.view.addSubview(btnInteraction)
        btnInteraction.isHidden = true
        btnInteraction.backgroundColor = UIColor.lightGray
        btnInteraction.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(btnInteraction.snp.width)
        }
    }
    
    override func viewDidLayoutSubviews() {
        tfUserID.layer.borderColor = UIColor.lightGray.cgColor
        tfUserID.layer.borderWidth = 1/UIScreen.main.scale/2
        tfUserID.layer.cornerRadius = 6
        btnInteraction.layer.cornerRadius = btnInteraction.bounds.width/2
    }
    
    
}
