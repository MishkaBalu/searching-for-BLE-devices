//
//  HeadphoneSettingsViewController.swift
//  BLEScanner
//
//  Created by Administrator on 05.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class HeadphoneSettingsViewController: UIViewController {

    @IBOutlet weak var leftHeadphone: UIImageView!
    @IBOutlet weak var rightHeadphone: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    
    func setupSendButton() {
        sendButton.layer.borderWidth = 1
        sendButton.layer.borderColor = UIColor.black.cgColor
        sendButton.layer.cornerRadius = 7
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSendButton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.leftHeadphone.image = UIImage(named: "left_headphone_activated")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.rightHeadphone.image = UIImage(named: "right_headphone_activated")
            }
        }
    }
}
