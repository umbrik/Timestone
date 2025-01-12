//
//  Utilities.swift
//  Timestone
//
//  Created by umbrik on 12.01.2025.
//

struct Utilities {
    static func formattedTime(seconds: Int) -> String {
        if seconds < 60 {
            return "\(max(seconds, 0))s"
        }

        let rest = seconds % 60

        if rest == 0 {
            return "\(seconds / 60)m"
        }

        return "\(seconds / 60)m \(rest)s"
    }
}
