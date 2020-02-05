//
//  HeadphoneSettingsViewController.swift
//  BLEScanner
//
//  Created by Administrator on 05.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class HeadphoneSettingsViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var leftHeadphone: UIImageView!
    @IBOutlet weak var rightHeadphone: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    
    //MARK: - Gesture Detection
    
    private func setupGestureDetectors() {
        let leftTap = UITapGestureRecognizer(target: self, action: #selector(self.leftTapAction))
        leftHeadphone.isUserInteractionEnabled = true
        leftHeadphone.addGestureRecognizer(leftTap)
        
        let rightTap = UITapGestureRecognizer(target: self, action: #selector(self.rightTapAction))
        rightHeadphone.isUserInteractionEnabled = true
        rightHeadphone.addGestureRecognizer(rightTap)
    }
    
    
    //MARK: - Properties
    private var leftHeadphoneEnabled = false {
        didSet {
            redrawLeftButton(enabled: leftHeadphoneEnabled)
            redrawSendButton(enabled: leftHeadphoneEnabled || rightHeadphoneEnabled)
        }
    }
    
    private var rightHeadphoneEnabled = false {
        didSet {
            redrawRightButton(enabled: rightHeadphoneEnabled)
            redrawSendButton(enabled: leftHeadphoneEnabled || rightHeadphoneEnabled)
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSendButton()
        setupGestureDetectors()
        setupNavigationBar()
    }
    
    //MARK: - UI Functions
    
    private func redrawLeftButton(enabled: Bool) {
        self.leftHeadphone.image = UIImage(named: enabled ? "left_headphone_activated" : "left_headphone")
    }
    
    private func redrawRightButton(enabled: Bool) {
        self.rightHeadphone.image = UIImage(named: enabled ? "right_headphone_activated" : "right_headphone")
    }
    
    private func setupSendButton() {
        sendButton.layer.borderWidth = 1
        sendButton.layer.borderColor = UIColor.black.cgColor
        sendButton.layer.cornerRadius = 7
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem?.image = UIImage(named: "back")
    }
    
    private func redrawSendButton(enabled: Bool) {
        sendButton.layer.borderColor = enabled ? UIColor.blue.cgColor : UIColor.black.cgColor
        sendButton.setTitleColor(enabled ? .blue : .black, for: .normal)
    }
    
    @objc func leftTapAction() {
        leftHeadphoneEnabled.toggle()
    }
    
    @objc func rightTapAction() {
        rightHeadphoneEnabled.toggle()
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
