//
//  TrailingLabelStyle.swift
//  Timestone
//
//  Created by umbrik on 11.01.2025.
//

import SwiftUI

struct TrailingLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingLabelStyle {
    static var trailingIcon: Self { Self() }
}
