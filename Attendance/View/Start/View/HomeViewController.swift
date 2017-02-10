//
//  IndexViewController.swift
//  Attendance
//
//  Created by 胡舒琦 on 2017/2/8.
//  Copyright © 2017年 胡舒琦. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import pop

class HomeViewController : UIViewController {
    var vControl:ControlView = ControlView()
    var vClock:ClockView = ClockView()
    
    var dynamic:UIDynamicAnimator!
    var conSnap:UISnapBehavior!
    var fingerConPoint:CGPoint!
    
    override func viewDidLoad() {
        self.view.addSubview(vClock)
        vClock.frame = CGRect(x:10, y:-20, width:UIScreen.main.bounds.size.width-20 ,height:200)
        
        self.view.addSubview(vControl)
        vControl.alpha = 0
        vControl.center = CGPoint(x:UIScreen.main.bounds.size.width/2,
                                  y:UIScreen.main.bounds.size.height)
        
        UIView.animate(withDuration: 0.6) {
            self.vControl.alpha = 1
        }
        
        dynamic = UIDynamicAnimator(referenceView: self.view)
        conSnap = UISnapBehavior(item: vControl, snapTo: CGPoint(x: vControl.center.x,
                                                                 y: vControl.center.y-vControl.bounds.size.height*1.5))
        
        dynamic.addBehavior(conSnap)
        
        let panGR:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self,
                                                                  action: #selector(HomeViewController.controlPanMove(panGR:)))
        vControl.addGestureRecognizer(panGR)
    }
    
    func controlPanMove(panGR:UIPanGestureRecognizer) {
        if panGR.state == UIGestureRecognizerState.began {
            dynamic.removeBehavior(conSnap)
            fingerConPoint = panGR.location(in: vControl)
        } else if panGR.state == UIGestureRecognizerState.ended ||
            panGR.state == UIGestureRecognizerState.cancelled ||
            panGR.state == UIGestureRecognizerState.failed {
            dynamic.addBehavior(conSnap)
        }
        
        let movePoint = panGR.location(in: self.view)
        vControl.center = CGPoint(x:movePoint.x+(vControl.bounds.size.width/2-fingerConPoint.x),
                                  y:movePoint.y+(vControl.bounds.size.height/2-fingerConPoint.y))
    }
}
