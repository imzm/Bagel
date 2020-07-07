//
//  DevicesViewModel.swift
//  Bagel
//
//  Created by Yagiz Gurgul on 1.10.2018.
//  Copyright © 2018 Yagiz Lab. All rights reserved.
//

import Cocoa

final class DevicesViewModel: BaseListViewModel<BagelDeviceController>  {

    func register() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshItems), name: BagelNotifications.didGetPacket, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshItems), name: BagelNotifications.didSelectProject, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshItems), name: BagelNotifications.didSelectDevice, object: nil)
    }
    
    var selectedItem: BagelDeviceController? {
        BagelController.shared.selectedProjectController?.selectedDeviceController
    }
    
    var selectedItemIndex: Int? {
        if let selectedItem = selectedItem {
            return items.firstIndex { $0 === selectedItem }
        }
        return nil
    }
    
    @objc func refreshItems() {
        set(items: BagelController.shared.selectedProjectController?.deviceControllers ?? [])
        onChange?()
    }
    
}
