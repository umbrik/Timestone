//
//  TimestoneApp.swift
//  Timestone
//
//  Created by umbrik on 11.01.2025.
//

import SwiftUI

@main
struct TimestoneApp: App {
    @StateObject private var store = ActivityStore()

    var body: some Scene {
        WindowGroup {
            ActivitiesView(activities: $store.activities) {
                Task {
                    do {
                        try await store.save(activities: store.activities)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
