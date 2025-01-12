//
//  History.swift
//  Timestone
//
//  Created by umbrik on 12.01.2025.
//

import Foundation


struct History: Identifiable, Codable {
    let id: UUID
    let startDate: Date
    let finishDate: Date

    init(id: UUID = UUID(), startDate: Date, finishDate: Date = Date()) {
        self.id = id
        self.startDate = startDate
        self.finishDate = finishDate
    }
}
