//
//  AlertableProtocol.swift
//  BLEScanner
//
//  Created by Shkolnyk Leonid on 06.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

public protocol Alertable {}
public extension Alertable where Self: UIViewController {
    
    func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: completion)
    }
}
