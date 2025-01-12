//
//  Activity.swift
//  Timestone
//
//  Created by umbrik on 11.01.2025.
//

import Foundation

struct Activity: Identifiable, Codable {
    var id: UUID
    var lengthInMinutes = 1
    var name: String
    var startDate: Date
    var theme: Theme
    var history: [History] = []
    var lengthInSeconds: Int {
        get {
            lengthInMinutes * 60
        }
    }

    init(id: UUID = UUID(), name: String, startDate: Date, theme: Theme, history: [History] = []) {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.theme = theme
        self.history = history
    }
}

extension Activity {
    static var emptyActivity: Activity {
        Activity(name: "", startDate: Date.now, theme: .sky)
    }
}

extension Activity {
    static let sampleData: [Activity] =
    [
        Activity(name: "Доработать snapshot тестирование в модуле wshcmx/cli ",
                 startDate: Date.now.advanced(by: 123),
                 theme: .yellow,
                 history: [History(startDate: Date.now, finishDate: Date.now.advanced(by: 10))]),
        Activity(name: "Позаниматься йогой",
                 startDate: Date.now.advanced(by: 14),
                   theme: .orange),
        Activity(name: "Сходить в магазин",
                 startDate: Date.now.advanced(by: 247),
                   theme: .poppy)
    ]
}
