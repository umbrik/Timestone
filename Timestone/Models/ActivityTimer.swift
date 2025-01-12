//
//  ActivityTimer.swift
//  Timestone
//
//  Created by umbrik on 11.01.2025.
//

import Foundation

@MainActor
final class ActivityTimer: ObservableObject {
    @Published var secondsElapsed = 0
    @Published var secondsRemaining = 0

    private(set) var lengthInMinutes: Int
    var stopTimerAction: (() -> Void)?

    private weak var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var secondsElapsedForSpeaker: Int = 0
    private var startDate: Date?

    init(lengthInMinutes: Int = 0) {
        self.lengthInMinutes = lengthInMinutes
        secondsRemaining = lengthInSeconds
    }

    func startActivity() {
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            self?.update()
        }
        startDate = Date()
        timer?.tolerance = 0.1
    }

    func stopActivity() {
        timer?.invalidate()
        timerStopped = true
    }

    nonisolated private func update() {
        Task { @MainActor in
            guard let startDate,
                  !timerStopped else { return }
            self.secondsElapsed = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)

            if secondsRemaining == 0 {
                stopActivity()
                stopTimerAction?()
            }
        }
    }

    func reset(lengthInMinutes: Int) {
        self.lengthInMinutes = lengthInMinutes
        secondsRemaining = lengthInSeconds
    }
}
