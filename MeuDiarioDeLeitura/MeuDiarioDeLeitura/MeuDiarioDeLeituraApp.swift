//
//  MeuDiarioDeLeituraApp.swift
//  MeuDiarioDeLeitura
//
//  Created by Joshua on 30/05/24.
//

import SwiftUI
import SwiftData

@main
struct MeuDiarioDeLeituraApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Book.self,
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
            HomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
