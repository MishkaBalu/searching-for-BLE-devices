//
//  HeadphonePresenter.swift
//  BLEScanner
//
//  Created by Administrator on 06.02.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import Foundation

protocol HeadphonePresenterProtocol: class {
    init(interface: HeadphoneSettingsViewProtocol, manager: BluetoothManagerProtocol)
    func sendCommand(to device: UUID, command: BluetoothCommands)
}

class HeadphonePresenter {
    
    private weak var view: HeadphoneSettingsViewProtocol!
    private var manager: BluetoothManagerProtocol!

    required init(interface: HeadphoneSettingsViewProtocol, manager: BluetoothManagerProtocol) {
        view = interface
        self.manager = manager
    }
}

extension HeadphonePresenter: HeadphonePresenterProtocol {
    func sendCommand(to device: UUID, command: BluetoothCommands) {
        manager.sendCommand(to: device, command: .play) { isSuccess in
            if isSuccess {
                self.view.commandSent()
            } else {
                self.view.commandError()
            }
        }
        //TODO: mock sending a command
    }
}
