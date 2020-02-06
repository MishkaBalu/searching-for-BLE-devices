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
    func sendCommand(to device: UUID, command: BluetoothCommands, completion: @escaping (Bool) -> Void)
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
            let model = Factory.make(model: devices)
            self?.view.didFindDevices(devices: model)
        }
    }
    
    func connectToDevice(UUID: UUID) -> Void {
        manager.connectToDevice(UUID: UUID) { [weak self] isSuccess in
            self?.view.connectToDevice(success: isSuccess)
        }
    }
    
    func sendCommand(to device: UUID, command: BluetoothCommands, completion: @escaping (Bool) -> Void) {
        manager.sendCommand(to: device, command: command, completion: completion)
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
