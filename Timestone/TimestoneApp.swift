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
    @State private var errorWrapper: ErrorWrapper?

    var body: some Scene {
        WindowGroup {
            ActivitiesView(activities: $store.activities) {
                Task {
                    do {
                        try await store.save(activities: store.activities)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Timestone will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper) {
                store.activities = Activity.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
