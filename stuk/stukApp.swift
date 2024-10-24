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
        }
    }
}
