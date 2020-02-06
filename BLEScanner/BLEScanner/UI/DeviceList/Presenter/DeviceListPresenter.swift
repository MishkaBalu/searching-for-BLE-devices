//
//  DeviceListPresenter.swift
//  BLEScanner
//
//  Created by Shkolnyk Leonid on 06.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol DeviceListPresenterProtocol: class {
    init(interface: DeviceListViewProtocol)
    func searchForDevices()
    func connectToDevice(UUID: UUID) -> Void
}

class DeviceListPresenter {
    private weak var view: DeviceListViewProtocol!
    private var manager: BluetoothManagerProtocol!
    
    required init(interface: DeviceListViewProtocol) {
        view = interface
        manager = BluetoothManager(timeout: 5.0)
    }
}

// MARK: - DeviceListPresenterProtocol

extension DeviceListPresenter: DeviceListPresenterProtocol {
    func searchForDevices() {
        manager.searchForDevices { [weak self] devices in
            if devices.count > 0 {
                let model = Factory.make(model: devices)
                self?.view.didFindDevices(devices: model)
            } else {
                self?.view.notFoundDevices()
            }
        }
    }
    
    func connectToDevice(UUID: UUID) -> Void {
        manager.connectToDevice(UUID: UUID) { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                let module = ModuleBuilder.createHeadphonesModule(with: self.manager)
                self.view.goToDevice(controller: module)
            } else {
                self.view.showError(message: "Unable to connect to Bluetooth device")
            }
        }
    }
}

// MARK: - Factory

extension DeviceListPresenter {
    enum Factory {
        static func make(model: [CBPeripheral]) -> DeviceListViewModel {
            DeviceListViewModel(devices: model.map { PeripheralDevice(title: $0.name?.uppercased() ?? "Unknown peripheral #\($0.identifier.description.components(separatedBy: "-")[0])".uppercased(), UUID: $0.identifier) } )
        }
    }
}
