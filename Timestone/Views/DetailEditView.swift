//
//  DetailEditView.swift
//  Timestone
//
//  Created by umbrik on 11.01.2025.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var activity: Activity

    var body: some View {
        Form {
            Section(header: Text("Activity Info")) {
                TextField("Name", text: $activity.name)
                ThemePicker(selection: $activity.theme)
            }
        }
    }
}


struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(activity: .constant(Activity.sampleData[0]))
    }
}
