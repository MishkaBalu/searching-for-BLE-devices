//
//  BluetoothManager.swift
//  BLEScanner
//
//  Created by Administrator on 05.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import Foundation
import CoreBluetooth

class BluetoothManager: NSObject, CBCentralManagerDelegate {
    
    private var centralManager: CBCentralManager!
    private var discoveredDevices = [CBPeripheral]()
    var timeout = 0.0
    
    init(timeout: Double) {
        super.init()
        self.timeout = timeout
        centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
    }
    
    func scanForDevices(completion: @escaping ([CBPeripheral]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
            completion(self.discoveredDevices)
        }
    }
    
    func connectToDevice(with UUID: UUID, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
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
