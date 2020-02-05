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
    private var bleManager: BluetoothManager!
    private var selected: UUID?
    
    //MARK: - IBActions
    @IBAction func connectButtonPressed(_ sender: UIButton) {
        selected.unwrap { [weak self] in
            self?.bleManager.connectToDevice(with: $0) { (success) in
                if success {
                    self?.navigationController?.pushViewController(HeadphoneSettingsViewController(), animated: true)
                } else {
                    self?.showAlert(title: "Bluetooth connection error", message: "An error during connecting to BLE device occured", preferredStyle: .alert)
                }
            }
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
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        setupConnectButton()
        searchView.frame = centerView.bounds
        self.centerView.addSubview(searchView)
        bleManager = BluetoothManager(timeout: 5.0)
        bleManager.scanForDevices { items in
            self.deviceListView.frame = self.centerView.bounds
            self.deviceListView.commonInit()
            self.deviceListView.delegate = self
            self.deviceListView.setModel(items.map({ PeripheralDevice(name: $0.name, UUID: $0.identifier) }))
            self.centerView.addSubview(self.deviceListView)
            self.setupConnectButton(items.count > 0, shouldAnimate: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSearching()
    }
    
    func startSearching() {
        searchView.animateSearching()
    }
    
    func setupConnectButton(_ isEnabled: Bool = false, shouldAnimate: Bool = false) {
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


extension Bundle {

    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}

extension Optional {
    @discardableResult
    func unwrap<Ret>(_ f: @escaping (Wrapped) -> Ret) -> Ret? {
        if case .some(let wrapped) = self { return f(wrapped) }
        return nil
    }
}

public protocol Alertable {}
public extension Alertable where Self: UIViewController {
    
    func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}
