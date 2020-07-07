//
//  BagelDeviceController.swift
//  Bagel
//
//  Created by Yagiz Gurgul on 24/09/2018.
//  Copyright © 2018 Yagiz Lab. All rights reserved.
//

import Cocoa

final class BagelDeviceController: NSObject {

    // MARK: - Properties
    
    var deviceId: String?
    var deviceName: String?
    var deviceDescription: String?
    
    var packets: [BagelPacket] = []
    private(set) var selectedPacket: BagelPacket?
    
    // MARK: - Methods
    
    func select(packet: BagelPacket?) {
        self.selectedPacket = packet
        self.notifyPacketSelection()
    }
    
    func notifyPacketSelection() {
        NotificationCenter.default.post(name: BagelNotifications.didSelectPacket, object: nil)
    }
    
    @discardableResult
    func addPacket(newPacket: BagelPacket) -> Bool {
        for packet in packets where packet.packetId == newPacket.packetId {
            packet.requestInfo = newPacket.requestInfo
            return false
        }
        
        packets.append(newPacket)
        
        if packets.count == 1 {
            selectedPacket = packets.first
        }
        
        return true
    }
    
    func clear() {
        packets.removeAll()
        select(packet: nil)
    }
}
