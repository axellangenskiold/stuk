//
//  Item.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-02.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
