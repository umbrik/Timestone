//
//  ActivityStore.swift
//  Timestone
//
//  Created by umbrik on 12.01.2025.
//

import SwiftUI

@MainActor
class ActivityStore: ObservableObject {
    @Published var activities: [Activity] = []

    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("activities.data")
    }

    func load() async throws {
        let task = Task<[Activity], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let activities = try JSONDecoder().decode([Activity].self, from: data)
            return activities
        }
        let activities = try await task.value
        self.activities = activities
    }

    func save(activities: [Activity]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(activities)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
