//
//  ClockView.swift
//  Attendance
//
//  Created by 胡舒琦 on 17/2/9.
//  Copyright © 2017年 胡舒琦. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ClockView: UIView {
    var viewModel:ClockViewModel = ClockViewModel()
    var labTime:UILabel = UILabel()
    var labDateDesc:UILabel = UILabel()
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        labDateDesc.font = UIFont.systemFont(ofSize: 20)
        labDateDesc.textColor = HColor.Dominant.withAlphaComponent(0.4)
        labDateDesc.textAlignment = .left
        self.addSubview(labDateDesc)
        labDateDesc.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        labTime.font = UIFont(name: "Digiface", size: 100)
        labTime.textColor = HColor.Dominant.withAlphaComponent(0.4)
        labTime.textAlignment = .center
        self.addSubview(labTime)
        labTime.snp.makeConstraints { (make) in
            make.top.equalTo(labDateDesc.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
        
        viewModel.dateDescription.asDriver().drive(labDateDesc.rx.text).addDisposableTo(disposeBag)
        viewModel.showTime.asDriver().drive(labTime.rx.text).addDisposableTo(disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 4
        self.layer.borderColor = HColor.Dominant.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 6
    }
}
