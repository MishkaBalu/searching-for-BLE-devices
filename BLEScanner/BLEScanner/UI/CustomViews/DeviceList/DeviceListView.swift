//
//  DeviceListView.swift
//  BLEScanner
//
//  Created by Administrator on 05.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit
import CoreBluetooth

class DeviceListView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [String]()
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func commonInit() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DeviceListTableViewCell", bundle: nil), forCellReuseIdentifier: "DeviceListTableViewCell")
    }
    
    func setModel(_ model: [String]) {
        self.items = model
        tableView.reloadData()
    }
}

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
}
