//
//  UIViewController+Extension.swift
//  BLEScanner
//
//  Created by Shkolnyk Leonid on 07.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func showToast() {
        setupNotificationView()
    }
    
    private func setupNotificationView() {
        let notificationView = PopUpView()
        view.addSubview(notificationView)
        
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            notificationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            notificationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            notificationView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
}
