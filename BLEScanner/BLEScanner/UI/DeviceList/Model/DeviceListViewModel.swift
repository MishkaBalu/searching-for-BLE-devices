//
//  DeviceListViewModel.swift
//  BLEScanner
//
//  Created by Shkolnyk Leonid on 06.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import Foundation
import CoreBluetooth

struct DeviceListViewModel {
    var devices: [PeripheralDevice]
}

struct PeripheralDevice {
    var title: String
    var UUID: UUID
}
