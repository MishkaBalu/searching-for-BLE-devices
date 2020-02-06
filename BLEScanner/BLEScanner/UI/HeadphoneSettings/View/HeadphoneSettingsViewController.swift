//
//  HeadphoneSettingsViewController.swift
//  BLEScanner
//
//  Created by Administrator on 05.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

protocol HeadphoneSettingsViewProtocol: class, Alertable {
    
}

class HeadphoneSettingsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var leftHeadphone: UIImageView!
    @IBOutlet weak var rightHeadphone: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    
    // MARK: - Gesture Detection
    
    private func setupGestureDetectors() {
        let leftTap = UITapGestureRecognizer(target: self, action: #selector(self.leftTapAction))
        leftHeadphone.isUserInteractionEnabled = true
        leftHeadphone.addGestureRecognizer(leftTap)
        
        let rightTap = UITapGestureRecognizer(target: self, action: #selector(self.rightTapAction))
        rightHeadphone.isUserInteractionEnabled = true
        rightHeadphone.addGestureRecognizer(rightTap)
    }
    
    // MARK: - Properties
    
    var presenter: HeadphonePresenterProtocol!
    
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
    
    // MARK: - Actions
    @IBAction func sendButtonTapped(_ sender: Any) {
//        presenter.sendCommand(to: <#T##UUID#>, command: <#T##BluetoothCommands#>, completion: <#T##(Bool) -> Void#>)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Functions
    
    private func redrawLeftButton(enabled: Bool) {
        self.leftHeadphone.image = UIImage(named: enabled ? "left_headphone_activated" : "left_headphone")
    }
    
    private func redrawRightButton(enabled: Bool) {
        self.rightHeadphone.image = UIImage(named: enabled ? "right_headphone_activated" : "right_headphone")
    }
    
    private func redrawSendButton(enabled: Bool) {
        self.sendButton.setImage(UIImage(named: enabled ? "send_blue" : "send_black"), for: .normal)
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

// MARK: - ControlSetupProtocol

extension HeadphoneSettingsViewController: ControlSetupProtocol {
    func setupUI() {
        setupSendButton()
        setupGestureDetectors()
        setupNavigationBar()
    }
    
    private func setupSendButton() {
        sendButton.layer.borderWidth = 1
        sendButton.layer.borderColor = UIColor.black.cgColor
        sendButton.layer.cornerRadius = 7
        sendButton.layer.shadowColor = UIColor.gray.cgColor
        sendButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        sendButton.layer.shadowOpacity = 1.0
        sendButton.layer.shadowRadius = 2.0
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem?.image = UIImage(named: "back")
    }
}

extension HeadphoneSettingsViewController: HeadphoneSettingsViewProtocol {
    
}
