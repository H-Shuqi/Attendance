//
//  HNavigationController.swift
//  Attendance
//
//  Created by 胡舒琦 on 17/2/10.
//  Copyright © 2017年 胡舒琦. All rights reserved.
//

import Foundation
import UIKit

class HNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        self.navigationBar.barTintColor = HColor.Dominant
        self.navigationBar.isTranslucent = false
    }
}
