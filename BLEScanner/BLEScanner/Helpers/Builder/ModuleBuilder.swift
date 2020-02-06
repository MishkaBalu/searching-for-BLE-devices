//
//  ModuleBuilder.swift
//  BLEScanner
//
//  Created by Shkolnyk Leonid on 06.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let model = DeviceListModel(devices: [])
        let view = DeviceListViewController()
        let presenter = DeviceListPresenter(interface: view, model: model)
        view.presenter = presenter
        return view
    }
}
