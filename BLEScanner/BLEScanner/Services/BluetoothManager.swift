//
//  BluetoothManager.swift
//  BLEScanner
//
//  Created by Administrator on 05.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import Foundation
import CoreBluetooth

public enum BluetoothCommands {
    case left, right, both
}

protocol BluetoothManagerProtocol: class {
    func set(timeout: Double)
    func searchForDevices(completion: @escaping ([CBPeripheral]) -> Void)
    func connectToDevice(UUID: UUID, completion: @escaping (Bool) -> Void)
    func sendCommand(to device: UUID, command: BluetoothCommands, completion: @escaping (Bool) -> Void)
}

class BluetoothManager: NSObject {
    
    private var centralManager: CBCentralManager!
    private var discoveredDevices = [CBPeripheral]()
    private var timeout = 0.0
    
    init(timeout: Double = 5.0) {
        super.init()
        self.timeout = timeout
        centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
    }
}


// MARK: - CBCentralManagerDelegate

extension BluetoothManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("Bluetooth is On")
            centralManager.scanForPeripherals(withServices: nil, options: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
                self.centralManager.stopScan()
            }
        } else {
            print("Bluetooth is not active")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        discoveredDevices.append(peripheral)
    }
}

// MARK: - BluetoothManagerProtocol

extension BluetoothManager: BluetoothManagerProtocol {
    func set(timeout: Double) {
        self.timeout = timeout
    }
    
    func searchForDevices(completion: @escaping ([CBPeripheral]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
            completion(self.discoveredDevices)
        }
    }
    
    func connectToDevice(UUID: UUID, completion: @escaping (Bool) -> Void) {
        completion(Bool.random())
    }
    
    func sendCommand(to device: UUID, command: BluetoothCommands, completion: @escaping (Bool) -> Void) {
        switch command {
        case .left:
            completion(Bool.random())
        case .right:
            completion(Bool.random())
        case .both:
            completion(Bool.random())
        }
    }
}
