//
//  DeviceListViewController.swift
//  BLEScanner
//
//  Created by Administrator on 05.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

protocol DeviceListViewProtocol: class {
    func didFindDevices(devices: DeviceListViewModel) -> Void
    func connectToDevice(success: Bool) -> Void
}

class DeviceListViewController: UIViewController, Alertable {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var deviceListLabel: UILabel!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var centerView: UIView!
    
    // MARK: - Properties
    
    private var searchView: SearchView!
    private var deviceListView: DeviceListView!
    private var selected: UUID?
    
    var presenter: DeviceListPresenterProtocol!
    
    // MARK: - IBActions
    
    @IBAction func connectButtonPressed(_ sender: UIButton) {
        selected.unwrap { [weak self] in self?.presenter.connectToDevice(UUID: $0) }
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        searchView = Bundle.loadView(fromNib: "SearchView", withType: SearchView.self)
        deviceListView = Bundle.loadView(fromNib: "DeviceListView", withType: DeviceListView.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.searchForDevices()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchView.animateSearching()
    }
}

// MARK: - DeviceListDelegate

extension DeviceListViewController: DeviceListDelegate {
    func selectedDevice(withUDID: UUID) {
        selected = withUDID
    }
}

// MARK: - ControlSetupProtocol

extension DeviceListViewController: ControlSetupProtocol {
    
    func setupUI() {
        setupNavigationBar()
        setupSearchView()
        setupConnectButton()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setupSearchView() {
        searchView.frame = centerView.bounds
        centerView.addSubview(searchView)
    }
    
    private func setupConnectButton(_ isEnabled: Bool = false, shouldAnimate: Bool = false) {
        if shouldAnimate {
            UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                self.connectButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
        }
        connectButton.setImage(UIImage(named: isEnabled ? "connect_selected" : "connect"), for: .normal)
        connectButton.setTitleColor(isEnabled ? .blue : .black, for: .normal)
        connectButton.tintColor = isEnabled ? .blue : .black
        connectButton.layer.borderWidth = 1
        connectButton.layer.borderColor = isEnabled ? UIColor.blue.cgColor : UIColor.black.cgColor
        connectButton.layer.cornerRadius = 7
        connectButton.layer.shadowColor = UIColor.gray.cgColor
        connectButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        connectButton.layer.shadowOpacity = 1.0
        connectButton.layer.shadowRadius = 2.0
    }
}

extension DeviceListViewController: DeviceListViewProtocol {
    
    func didFindDevices(devices: DeviceListViewModel) {
        if devices.devices.count > 0 {
            self.deviceListView.frame = self.centerView.bounds
            self.deviceListView.delegate = self
            self.deviceListView.commonInit(devices)
            self.centerView.addSubview(self.deviceListView)
            self.setupConnectButton(true, shouldAnimate: true)
        } else {
            self.showAlert(title: "No Bluetooth devices found", message: "", preferredStyle: .alert)
        }
    }
    
    func connectToDevice(success: Bool) {
        if success {
            navigationController?.pushViewController(HeadphoneSettingsViewController(), animated: true)
        } else {
            showAlert(title: "Bluetooth connection error", message: "An error during connecting to BLE device occured", preferredStyle: .alert)
        }
    }
}
