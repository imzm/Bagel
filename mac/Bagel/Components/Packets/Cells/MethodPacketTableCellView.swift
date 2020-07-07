//
//  MethodPacketTableCellView.swift
//  Bagel
//
//  Created by Yagiz Gurgul on 31.12.2018.
//  Copyright © 2018 Yagiz Lab. All rights reserved.
//

import Cocoa
import macOSThemeKit

final class MethodPacketTableCellView: NSTableCellView {
    
    @IBOutlet private weak var titleTextField: NSTextField!
    
    var packet: BagelPacket? {
        didSet {
            guard let packet = packet else { return }
            refresh(with: packet)
        }
    }

    func refresh(with packet: BagelPacket) {
        guard let requestMethod = packet.requestInfo?.requestMethod else { return }
        
        var methodColor = ThemeColor.httpMethodDefaultColor
        switch requestMethod {
        case .get:
            methodColor = ThemeColor.httpMethodGetColor
            
        case .put:
            methodColor = ThemeColor.httpMethodPutColor
            
        case .post:
            methodColor = ThemeColor.httpMethodPostColor
            
        case .delete:
            methodColor = ThemeColor.httpMethodDeleteColor
            
        case .patch:
            methodColor = ThemeColor.httpMethodPatchColor
            
        case .head:
            break
        }
        
        titleTextField.textColor = methodColor
        titleTextField.stringValue = packet.requestInfo?.requestMethod?.rawValue ?? ""
    }
    
}
