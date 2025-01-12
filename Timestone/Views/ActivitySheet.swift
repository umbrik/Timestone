//
//  ActivitySheet.swift
//  Timestone
//
//  Created by umbrik on 12.01.2025.
//

import SwiftUI

struct NewActivitySheet: View {
    @State private var newActivity = Activity.emptyActivity
    @Binding var activities: [Activity]
    @Binding var isPresentingNewActivityView: Bool

    var body: some View {
        NavigationStack {
            DetailEditView(activity: $newActivity)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewActivityView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            activities.append(newActivity)
                            isPresentingNewActivityView = false
                        }
                    }
                }
        }
    }
}

struct NewActivitySheet_Previews: PreviewProvider {
    static var previews: some View {
        NewActivitySheet(activities: .constant(Activity.sampleData), isPresentingNewActivityView: .constant(true))
    }
}
