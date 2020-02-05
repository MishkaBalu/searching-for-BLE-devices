//
//  DeviceListView.swift
//  BLEScanner
//
//  Created by Administrator on 05.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class DeviceListView: UIView {
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: DeviceListDelegate!
    
    var items = [PeripheralDevice]()
    
    // MARK: - Init
    
    func commonInit(_ model: [PeripheralDevice]) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DeviceListTableViewCell", bundle: nil), forCellReuseIdentifier: "DeviceListTableViewCell")
        items = model
        tableView.reloadData()
    }
    
    // MARK: - awakeFromNib()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension DeviceListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceListTableViewCell", for: indexPath) as? DeviceListTableViewCell else { return UITableViewCell() }
        cell.configureCell(items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.selectedDevice(withUDID: items[indexPath.row].UUID)
    }
}

protocol DeviceListDelegate: class {
    func selectedDevice(withUDID: UUID) -> Void
}

struct PeripheralDevice {
    var name: String?
    var UUID: UUID
}
