//
//  BaseViewController.swift
//  BLEScanner
//
//  Created by Administrator on 07.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private enum Consts {
        static let timeInterval: Double = 5.0
    }
    
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        initTimer()
    }
    
    func initTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(Consts.timeInterval),
                                         target: self,
                                         selector: #selector(timerHandler),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    @objc func timerHandler() {
        
    }

}
