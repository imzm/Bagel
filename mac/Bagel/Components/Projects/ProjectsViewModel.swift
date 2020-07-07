//
//  ProjectsViewModel.swift
//  Bagel
//
//  Created by Yagiz Gurgul on 30/08/2018.
//  Copyright © 2018 Yagiz Lab. All rights reserved.
//

import Cocoa

final class ProjectsViewModel: BaseListViewModel<BagelProjectController> {

    func register() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshItems), name: BagelNotifications.didGetPacket, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshItems), name: BagelNotifications.didSelectProject, object: nil)
    }
    
    var selectedItem: BagelProjectController? {
        BagelController.shared.selectedProjectController
    }
    
    var selectedItemIndex: Int? {
        if let selectedItem = selectedItem {
            return items.firstIndex { $0 === selectedItem }
        }
        return nil
    }
    
    @objc func refreshItems() {
        set(items: BagelController.shared.projectControllers)
        onChange?()
    }
    
}
