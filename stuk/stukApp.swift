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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView(path: $path)
        }
        .modelContainer(sharedModelContainer)
    }
}
