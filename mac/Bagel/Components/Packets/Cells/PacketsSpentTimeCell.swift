//
//  PacketsSpentTimeCell.swift
//  Bagel
//
//  Created by Max Zakurin on 07.07.2020.
//  Copyright © 2020 Yagiz Lab. All rights reserved.
//

import Cocoa
import macOSThemeKit

final class PacketsSpentTimeCell: NSTableCellView {
    
    @IBOutlet private weak var titleTextField: NSTextField!
    
    var packet: BagelPacket? {
        didSet {
            guard let packet = packet else { return }
            refresh(with: packet)
        }
    }
    
    func refresh(with packet: BagelPacket) {
        guard let requestInfo = packet.requestInfo, let startDate = requestInfo.startDate, let endDate = requestInfo.endDate
            else { return }
        
        titleTextField.textColor = ThemeColor.secondaryLabelColor
        titleTextField.stringValue = String(endDate.timeIntervalSince(startDate)) + " ms"
    }
    
}
