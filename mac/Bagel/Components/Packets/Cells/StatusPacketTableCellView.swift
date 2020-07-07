//
//  StatusPacketTableCellView.swift
//  Bagel
//
//  Created by Yagiz Gurgul on 1.10.2018.
//  Copyright © 2018 Yagiz Lab. All rights reserved.
//

import Cocoa
import macOSThemeKit

final class StatusPacketTableCellView: NSTableCellView {

    @IBOutlet weak var titleTextField: NSTextField!
    
    var packet: BagelPacket! {
        didSet { refresh() }
    }
    
    func refresh() {
        guard let statusCodeString = packet.requestInfo?.statusCode, let statusCode = Int(statusCodeString) else { return }
        
        switch statusCode {
        case 200..<300:
            titleTextField.textColor = ThemeColor.statusGreenColor
            
        case 300..<400:
            titleTextField.textColor = ThemeColor.statusOrangeColor
            
        case 400:
            titleTextField.textColor = ThemeColor.statusRedColor
            
        default:
            break
        }
        
        titleTextField.stringValue = statusCodeString
    }
    
}
