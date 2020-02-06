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
        let view = UIStoryboard(name: "DeviceList", bundle: nil).instantiateViewController(withIdentifier: "DeviceList") as! DeviceListViewController
        let presenter = DeviceListPresenter(interface: view)
        view.presenter = presenter
        return view
    }
    
    static func createHeadphonesModule(with manager: BluetoothManagerProtocol) -> UIViewController {
        let view = HeadphoneSettingsViewController()
        let presenter = HeadphonePresenter(interface: view, manager: manager)
        view.presenter = presenter
        return view
    }
}
