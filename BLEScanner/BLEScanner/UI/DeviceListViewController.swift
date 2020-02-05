//
//  DeviceListViewController.swift
//  BLEScanner
//
//  Created by Administrator on 05.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class DeviceListViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var deviceListLabel: UILabel!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var centerView: UIView!
    
    //MARK: - Lifecycle
    
    var searchView: SearchView!
    var deviceListView: DeviceListView!
    var scanner: BluetoothManager!
    
    override func loadView() {
        super.loadView()
        searchView = Bundle.loadView(fromNib: "SearchView", withType: SearchView.self)
        deviceListView = Bundle.loadView(fromNib: "DeviceListView", withType: DeviceListView.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.frame = centerView.bounds
        self.centerView.addSubview(searchView)
        scanner = BluetoothManager(timeout: 5.0)
        scanner.scanForDevices { items in
            self.deviceListView.frame = self.centerView.bounds
            self.deviceListView.commonInit()
            self.deviceListView.setModel(items.map({$0.identifier.description}))
            self.centerView.addSubview(self.deviceListView)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSearching()
    }
    
    func startSearching() {
        searchView.animateSearching()
    }
}


extension Bundle {

    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}
