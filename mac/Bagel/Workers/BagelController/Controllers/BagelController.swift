//
//  BagelController.swift
//  Bagel
//
//  Created by Yagiz Gurgul on 24/09/2018.
//  Copyright © 2018 Yagiz Lab. All rights reserved.
//

import Cocoa

struct BagelNotifications {
    static let didGetPacket = NSNotification.Name("DidGetPacket")
    static let didUpdatePacket = NSNotification.Name("DidUpdatePacket")
    static let didSelectProject = NSNotification.Name("DidSelectProject")
    static let didSelectDevice = NSNotification.Name("DidSelectDevice")
    static let didSelectPacket = NSNotification.Name("DidSelectPacket")
}

final class BagelController: NSObject, BagelPublisherDelegate {
    
    // MARK: - Properties
    
    static let shared = BagelController()
    
    var projectControllers: [BagelProjectController] = []
    var selectedProjectController: BagelProjectController? {
        didSet {
            NotificationCenter.default.post(name: BagelNotifications.didSelectProject, object: nil)
        }
    }
    
    var publisher = BagelPublisher()
    
    // MARK: - Methods
    
    override init() {
        super.init()
        
        self.publisher.delegate = self
        self.publisher.startPublishing()
    }
    
    func didGetPacket(publisher: BagelPublisher, packet: BagelPacket) {
        if addPacket(newPacket: packet) {
            NotificationCenter.default.post(name: BagelNotifications.didGetPacket, object: nil, userInfo: ["packet": packet])
            checkInitialSelection()
        } else {
            NotificationCenter.default.post(name: BagelNotifications.didUpdatePacket, object: nil, userInfo: ["packet": packet])
        }
    }
    
    @discardableResult
    func addPacket(newPacket: BagelPacket) -> Bool {
        for controller in projectControllers where controller.projectName == newPacket.project?.projectName {
            return controller.addPacket(newPacket: newPacket)
        }
        
        let projectController = BagelProjectController()
        
        projectController.projectName = newPacket.project?.projectName
        projectController.addPacket(newPacket: newPacket)
        
        self.projectControllers.append(projectController)
        
        if projectControllers.count == 1 {
            selectedProjectController = projectControllers.first
        }
        
        return true
    }
    
    
    func checkInitialSelection() {
        if self.selectedProjectController?.selectedDeviceController?.packets.count == 1 {
            self.selectedProjectController?.selectedDeviceController?.notifyPacketSelection()
        }
    }
    
}
