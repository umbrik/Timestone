//
//  DetailView.swift
//  Timestone
//
//  Created by umbrik on 11.01.2025.
//

import SwiftUI

struct DetailView: View {
    @Binding var activity: Activity

    @State private var editingActivity = Activity.emptyActivity
    @State private var isPresentingEditView = false

    var body: some View {
        List {
            Section(header: Text("Activity Info")) {
                NavigationLink(destination: ActivityView(activity: $activity)) {
                    Label("Start", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Duration", systemImage: "clock")
                    Spacer()
                    Text("\(activity.lengthInMinutes)m")
                }
                    .disabled(true)
                HStack {
                    Label("Elapsed", systemImage: "clock")
                    Spacer()
                    Text("\(Utilities.formattedTime(seconds: activity.lengthInSeconds - Int(activity.startDate.timeIntervalSince(Date.now))))")
                }
                    .disabled(true)
                HStack {
                    Label("Remaining", systemImage: "clock")
                    Spacer()
                    Text("\(Utilities.formattedTime(seconds: Int(activity.startDate.timeIntervalSince(Date.now))))")
                }
                    .disabled(true)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(activity.theme.name)
                        .padding(4)
                        .foregroundColor(activity.theme.accentColor)
                        .background(activity.theme.mainColor)
                        .cornerRadius(4)
                }
            }
            Section(header: Text("History")) {
                if activity.history.isEmpty {
                    Label("No records yet", systemImage: "calendar.badge.exclamationmark")
                        .disabled(true)
                }
                ForEach(activity.history) { history in
                    HStack {
                        Image(systemName: "clock")
                        Text(history.startDate.formatted(date: .omitted, time: .standard))
                            .font(.caption)
                            .padding(.trailing)
                        Spacer()
                        Text(history.finishDate.formatted(date: .omitted, time: .standard))
                            .font(.caption)
                            .padding(.trailing)
                        Image(systemName: "clock")
                    }
                }
            }
        }
        .navigationTitle(activity.name)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                editingActivity = activity
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(activity: $editingActivity)
                    .navigationTitle(activity.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = true
                                activity = editingActivity
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(activity: .constant(Activity.sampleData[0]))
        }
    }
}
