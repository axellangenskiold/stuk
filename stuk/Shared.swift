//
//  Shared.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-19.
//

import Foundation

class Shared {
    static let shared = Shared()
    
    var name: String = "Mikael Bamberg"
    
    var initials: String = "MB"
    
    var email: String = "mikaelbamberg@gmail.com"
    
    var personNbr: String = "030605-7977"
    
    private init() {}
}
