//
//  PacketViewModel.swift
//  Bagel
//
//  Created by Yagiz Gurgul on 1.10.2018.
//  Copyright © 2018 Yagiz Lab. All rights reserved.
//

import Cocoa

final class PacketsViewModel: BaseListViewModel<BagelPacket>  {
    
    // MARK: - Properties
    
    var addressFilterTerm = "" {
        didSet { refreshItems() }
    }
    
    var methodFilterTerm = "" {
        didSet { refreshItems() }
    }
    
    var statusFilterTerm = "" {
        didSet { refreshItems() }
    }
    
    private var allPackets: [BagelPacket] {
        BagelController.shared.selectedProjectController?.selectedDeviceController?.packets ?? []
    }
    
    var selectedItem: BagelPacket? {
        BagelController.shared.selectedProjectController?.selectedDeviceController?.selectedPacket
    }
    
    var selectedItemIndex: Int? {
        guard let selectedItem = selectedItem else { return nil }
        return items.firstIndex { $0 === selectedItem }
    }
    
    // MARK: - Methods
    
    func register() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshItems),
                                               name: BagelNotifications.didGetPacket,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshItems),
                                               name: BagelNotifications.didUpdatePacket,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshItems),
                                               name: BagelNotifications.didSelectProject,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshItems),
                                               name: BagelNotifications.didSelectDevice,
                                               object: nil)
    }
    
    @objc func refreshItems() {
        items = filter(items: allPackets)
        onChange?()
    }
    
    func filter(items: [BagelPacket]) -> [BagelPacket] {
        var filteredItems = performAddressFiltration(items)
        filteredItems = performMethodFiltration(filteredItems)
        return performStatusFiltration(filteredItems)
    }
    
    func performAddressFiltration(_ items: [BagelPacket])  -> [BagelPacket] {
        guard !addressFilterTerm.isEmpty else { return items }
        
        return items.filter { $0.requestInfo?.url?.contains(addressFilterTerm) ?? true }
    }
    
    func performMethodFiltration(_ items: [BagelPacket])  -> [BagelPacket] {
        guard !methodFilterTerm.isEmpty else { return items }
        
        return items.filter
            { $0.requestInfo?.requestMethod?.rawValue.lowercased()
                .contains(methodFilterTerm.lowercased()) ?? true }
    }
    
    func performStatusFiltration(_ items: [BagelPacket])  -> [BagelPacket] {
        guard !statusFilterTerm.isEmpty else { return items }
        
        guard !statusFilterTerm.trimmingCharacters(in: .whitespaces).isEmpty else {
            return items.filter { $0.requestInfo?.statusCode?.trimmingCharacters(in: .whitespaces).isEmpty ?? true}
        }
        
        return items.filter { $0.requestInfo?.statusCode?.contains(statusFilterTerm) ?? false }
    }
    
    func clearPackets() {
        BagelController.shared.selectedProjectController?.selectedDeviceController?.clear()
        refreshItems()
    }
    
}
