//
//  Optional+Extension.swift
//  BLEScanner
//
//  Created by Shkolnyk Leonid on 06.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import Foundation

extension Optional {
    @discardableResult
    func unwrap<Ret>(_ f: @escaping (Wrapped) -> Ret) -> Ret? {
        if case .some(let wrapped) = self { return f(wrapped) }
        return nil
    }
}
