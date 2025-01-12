//
//  MeetingHeaderView.swift
//  Timestone
//
//  Created by umbrik on 11.01.2025.
//

import SwiftUI

struct ActivityHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme

    private var totalSeconds: Int {
        return secondsElapsed + secondsRemaining
    }
    private var progress: Double {

        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }

    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ActivityProgressViewStyle(theme: theme))
            HStack {
                VStack {
                    Text("Elapsed time")
                        .font(.caption)
                    Label("\(Utilities.formattedTime(seconds: secondsElapsed))", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack {
                    Text("Remaining time")
                        .font(.caption)
                    Label("\(Utilities.formattedTime(seconds: secondsRemaining))", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .padding([.top, .horizontal])
    }
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityHeaderView(secondsElapsed: 60, secondsRemaining: 100, theme: .bubblegum)
    }
}
