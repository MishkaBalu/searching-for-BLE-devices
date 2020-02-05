//
//  DeviceListViewController.swift
//  BLEScanner
//
//  Created by Administrator on 05.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class DeviceListViewController: UIViewController, Alertable {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var deviceListLabel: UILabel!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var centerView: UIView!
    
    //MARK: - Properties
    
    private var searchView: SearchView!
    private var deviceListView: DeviceListView!
    private var selected: UUID?
    
    private var presenter: DeviceListPresenterProtocol?
    
    //MARK: - IBActions
    @IBAction func connectButtonPressed(_ sender: UIButton) {
        selected.unwrap { [weak self] in
            self?.presenter?.connectToDevice(UUID: $0, completion: { isSuccess in
                if isSuccess {
                    self?.navigationController?.pushViewController(HeadphoneSettingsViewController(), animated: true)
                } else {
                    self?.showAlert(title: "Bluetooth connection error", message: "An error during connecting to BLE device occured", preferredStyle: .alert)
                }
            })
        }
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        searchView = Bundle.loadView(fromNib: "SearchView", withType: SearchView.self)
        deviceListView = Bundle.loadView(fromNib: "DeviceListView", withType: DeviceListView.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchView.animateSearching()
    }
    
    private func setupSearchView() {
        searchView.frame = centerView.bounds
        centerView.addSubview(searchView)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setupConnectButton(_ isEnabled: Bool = false, shouldAnimate: Bool = false) {
        if shouldAnimate {
            UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                self.connectButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
        }
        connectButton.imageView?.image = UIImage(named: isEnabled ? "send_blue" : "send_black")
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

extension DeviceListViewController: DeviceListDelegate {
    func selectedDevice(withUDID: UUID) {
        selected = withUDID
    }
}

extension DeviceListViewController: ControlSetupProtocol {
    func setupUI() {
        setupNavigationBar()
        setupConnectButton()
        setupSearchView()
    }
    
    func setupPresenter() {
        presenter = DeviceListPresenter(service: BluetoothManager(timeout: 5.0))
        presenter?.searchForDevices { [weak self] models in
            guard let self = self else { return }
            self.deviceListView.frame = self.centerView.bounds
            self.deviceListView.delegate = self
            self.deviceListView.commonInit(models.map({ PeripheralDevice(name: $0.name, UUID: $0.identifier) }))
            self.centerView.addSubview(self.deviceListView)
            self.setupConnectButton(models.count > 0, shouldAnimate: true)
        }
    }
}
