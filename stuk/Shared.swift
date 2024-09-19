//
//  Shared.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-19.
//

import Foundation

class Shared {
    static let shared = Shared()
    
    var name: String = "Axel Langenskiöld"
    
    var initials: String = "AL"
    
    var email: String = "axel@langenskiold.se"
    
    var personNbr: String = "020117-3713"
    
    private init() {}
}
