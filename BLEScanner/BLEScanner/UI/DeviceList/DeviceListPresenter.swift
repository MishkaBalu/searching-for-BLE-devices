//
//  DeviceListPresenter.swift
//  BLEScanner
//
//  Created by Shkolnyk Leonid on 06.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import Foundation
import CoreBluetooth

enum BluetoothCommands {
    case disconnect, play, pause, next
}

protocol DeviceListPresenterProtocol: class {
    init(interface: DeviceListViewProtocol, model: DeviceListModel)
    func searchForDevices(completion: @escaping ([CBPeripheral]) -> Void)
    func connectToDevice(UUID: UUID, completion: @escaping (Bool) -> Void)
    func sendCommand(to device: UUID, command: BluetoothCommands, completion: @escaping (Bool) -> Void)
}

class DeviceListPresenter {
    private let view: DeviceListViewProtocol
    private let model: DeviceListModel
    private var manager: BluetoothManagerProtocol!
    
    required init(interface: DeviceListViewProtocol, model: DeviceListModel) {
        view = interface
        self.model = model
        manager = BluetoothManager(timeout: 5.0)
    }
}

extension DeviceListPresenter: DeviceListPresenterProtocol {
    func searchForDevices(completion: @escaping ([CBPeripheral]) -> Void) {
        manager.searchForDevices(completion: completion)
    }
    
    func connectToDevice(UUID: UUID, completion: @escaping (Bool) -> Void) {
        manager.connectToDevice(UUID: UUID, completion: completion)
    }
    
    func sendCommand(to device: UUID, command: BluetoothCommands, completion: @escaping (Bool) -> Void) {
        manager.sendCommand(to: device, command: command, completion: completion)
    }
}
