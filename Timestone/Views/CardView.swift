//
//  CardView.swift
//  Timestone
//
//  Created by umbrik on 11.01.2025.
//

import SwiftUI

struct CardView: View {
    let activity: Activity
    var body: some View {
        VStack(alignment: .leading) {
            Text(activity.name)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(activity.startDate.formatted(date: .omitted, time: .standard))", systemImage: "calendar")
                Spacer()
                Label("\(Utilities.formattedTime(seconds: Int(activity.startDate.timeIntervalSince(Date.now))))", systemImage: "clock")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(activity.theme.accentColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var activity = Activity.sampleData[0]
    static var previews: some View {
        CardView(activity: activity)
            .background(activity.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
