//Copyright © 2021 Apple Inc. All rights reserved.

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Text("Email Id: \(DataStore.sharedInstance.getValueForKey(.emailId))")
                .font(.headline)
            Text("Domain: \(DataStore.sharedInstance.getValueForKey(.domain))")
            Text("Focus Area: \(DataStore.sharedInstance.getValueForKey(.focusArea))")
            Text("Language:\(DataStore.sharedInstance.getValueForKey(.language))")
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .environment(\.defaultMinListRowHeight, 50)
    }
}

#Preview {
    SettingsView()
}
