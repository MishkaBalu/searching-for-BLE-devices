//
//  PopupView.swift
//  BLEScanner
//
//  Created by Shkolnyk Leonid on 06.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class PopUpView: UIView {
    
    private enum Consts {
        static let timeout: Double = 3.5
        static let resetAnimationTime: Double = 1.0
        static let durationAnimationTime: Double = 0.5
    }
    
    private enum NotificationSate: CaseIterable {
        case green
        case red
        case blue
    }
    
    private var buttonState: NotificationSate = .blue
    private let fromPossition = CGAffineTransform(translationX: 0, y: 0)
    private let toPossition = CGAffineTransform(translationX: 0, y: 50)
    
    private let iconImageView = UIImageView(image: UIImage(named: "information"))
    private let notificatioLabel = UILabel()
    
    private var isRed = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        randomNotoficationGenerator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func popup(with state: ConnectionStatus) {
        switch state {
        case .connected:
            setupView(with: .blue)
        case .disconnected:
            setupView(with: .red)
        case .commandSent:
            setupView(with: .green)
        }
    }
    
    private func setupView(with state: NotificationSate) {
        switch state {
        case .red: backgroundColor = .red; notificatioLabel.text = "Connection failure"
        case .green: backgroundColor = .green; notificatioLabel.text = "Command sent"
        case .blue: backgroundColor = UIColor(red: 120/255, green: 156/255, blue: 202/255, alpha: 1); notificatioLabel.text = "Device connected"
        }
        
        layer.cornerRadius = 3
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        notificatioLabel.font = UIFont(name: "Menlo-Regular", size: 16)
        notificatioLabel.textColor = .white
        
        addSubview(iconImageView)
        addSubview(notificatioLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        notificatioLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 35),
            iconImageView.widthAnchor.constraint(equalToConstant: 35),
            
            notificatioLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16),
            notificatioLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor)
        ])
    }
    
    func randomNotoficationGenerator() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Consts.timeout) { [weak self] in
            guard let self = self else { return }
            if self.isRed {
                self.buttonState = .red
                self.setupView(with: .red)
            } else {
                self.buttonState = .blue
                self.setupView(with: .blue)
            }
            self.isRed.toggle()
            self.animate {
                self.randomNotoficationGenerator()
            }
        }
    }
    
    func animate(_ completion: () -> Void) {
        isHidden = false
        UIView.animate(withDuration: Consts.durationAnimationTime, animations: {
            self.alpha = 1.0
            self.transform = self.toPossition
        }, completion: { (isCompleted) in
            if isCompleted {
                self.randomNotoficationGenerator()
                self.removeNotificationView()
            }
        })
    }
    
    func removeNotificationView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Consts.resetAnimationTime) {
            UIView.animate(withDuration: Consts.durationAnimationTime) {
                self.transform = self.fromPossition
                self.alpha = 0.0
            }
        }
    }
}
