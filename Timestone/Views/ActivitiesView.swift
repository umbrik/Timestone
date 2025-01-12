//
//  ActivitiesView.swift
//  Timestone
//
//  Created by umbrik on 11.01.2025.
//

import SwiftUI

struct ActivitiesView: View {
    @Binding var activities: [Activity]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewActivityView = false
    let saveAction: ()->Void

    var body: some View {
        NavigationStack {
            List($activities) { $activity in
                NavigationLink(destination: DetailView(activity: $activity)) {
                    CardView(activity: activity)
                }
                .listRowBackground(activity.theme.mainColor)
            }
            .navigationTitle("Activities")
            .toolbar {
                Button(action: {
                    isPresentingNewActivityView = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingNewActivityView) {
            NewActivitySheet(activities: $activities, isPresentingNewActivityView: $isPresentingNewActivityView)
        }
        .onChange(of: scenePhase, initial: true) { _, newValue  in
            if newValue == .inactive {
                saveAction()
            }
        }
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView(activities: .constant(Activity.sampleData), saveAction: {})
    }
}
