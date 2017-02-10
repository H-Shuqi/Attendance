//
//  ControlView.swift
//  Attendance
//
//  Created by 胡舒琦 on 17/2/9.
//  Copyright © 2017年 胡舒琦. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ControlView: UIView {
    
    enum OrginState {
        case float
        case top
        case left
        case bottom
        case right
    }
    
    static let defalutSize:CGSize = CGSize(width:200, height:200)
    var orginState:OrginState = .float
    var startOrgin:Float?
    var sustainOrgin:Float?
    
    convenience init() {
        self.init(frame:CGRect(origin: CGPoint.zero, size: ControlView.defalutSize))
        self.backgroundColor = HColor.clear
        
        self.layer.shadowColor = HColor.Dominant.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width:2, height:2)
        
        self.addObserver(self, forKeyPath: "center", options: .new, context: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let point = change?[.newKey] as! CGPoint
        print("Ctntrol Center : \(point)")
    }
    
    override func draw(_ rect: CGRect) {
        if orginState == .float {
            let ovalLPath = UIBezierPath(ovalIn: self.bounds)
            HColor.Dominant.setFill()
            ovalLPath.fill()
        }else if orginState == .left {
            
        }else if orginState == .right {
            
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "center")
    }
}

