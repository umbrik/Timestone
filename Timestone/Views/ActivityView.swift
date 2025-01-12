//
//  ContentView.swift
//  Timestone
//
//  Created by umbrik on 11.01.2025.
//

import SwiftUI
import AVFoundation

struct ActivityView: View {
    @Binding var activity: Activity
    @StateObject var activityTimer = ActivityTimer()

    private var player: AVPlayer { AVPlayer.sharedDingPlayer}

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(activity.theme.mainColor)
            VStack {
                ActivityHeaderView(secondsElapsed: activityTimer.secondsElapsed, secondsRemaining: activityTimer.secondsRemaining, theme: activity.theme)
                Circle()
                    .strokeBorder(lineWidth: 10)
            }
            .padding()
        }
        .padding()
        .foregroundColor(activity.theme.accentColor)
        .onAppear {
            startActivity()
        }
        .onDisappear {
            endActivity()
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func startActivity() {
        activityTimer.reset(lengthInMinutes: activity.lengthInMinutes)
        activityTimer.stopTimerAction = {
            player.seek(to: .zero)
            player.play()
        }
        activityTimer.startActivity()
    }

    private func endActivity() {
        activityTimer.stopActivity()
        let newHistory = History(startDate: activity.startDate)
        activity.history.insert(newHistory, at: 0)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activity: .constant(Activity.sampleData[0]))
    }
}
