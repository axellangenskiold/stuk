//
//  stukApp.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-02.
//

import SwiftUI
import SwiftData

@main
struct stukApp: App {
    @State private var path = NavigationPath()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .onAppear {
                    let defaults = UserDefaults.standard
                    
                    let fp = defaults.double(forKey: "firstPadding")
                    Shared.shared.firstPadding = CGFloat(fp)
                    
                    let sp = defaults.double(forKey: "secondPadding")
                    Shared.shared.secondPadding = CGFloat(sp)
                    
                    let name = defaults.string(forKey: "name")
                    Shared.shared.name = name ?? "Dallas i Kurra"
                    
                    let personNbr = defaults.string(forKey: "personnummer")
                    Shared.shared.personNbr = personNbr ?? "696969-xxxx"
                    
                    let email = defaults.string(forKey: "email")
                    Shared.shared.email = email ?? "x@y.se"
                    
                    let initials = defaults.string(forKey: "intials")
                    Shared.shared.initials = personNbr ?? "KD"
                }
        }
    }
}
