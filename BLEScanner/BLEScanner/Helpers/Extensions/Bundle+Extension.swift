//
//  Bundle+Extension.swift
//  BLEScanner
//
//  Created by Shkolnyk Leonid on 06.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import Foundation

extension Bundle {

    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}
