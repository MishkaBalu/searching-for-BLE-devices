//
//  DeviceListTableViewCell.swift
//  BLEScanner
//
//  Created by Administrator on 05.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class DeviceListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var deviceNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ model: PeripheralDevice) {
        self.deviceNameLabel.text = model.name?.uppercased() ?? "Unknown peripheral #\(model.UUID.description.components(separatedBy: "-")[0])".uppercased()
    }
}
