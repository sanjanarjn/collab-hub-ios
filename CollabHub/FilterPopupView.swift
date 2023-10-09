//Copyright © 2021 Apple Inc. All rights reserved.

import SwiftUI

struct FilterPopupView: View {
    @Binding var isPresented: Bool
    @State private var selectedOptions: Set<String> = [] // Store selected options here
    @Binding var filterPriority: String

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Filter Options")) {
                    // Add your filter options here
                    ForEach(["good first issue", "bug", "improvement", "help wanted"], id: \.self) { option in
                        Toggle(option, isOn: Binding(
                            get: { selectedOptions.contains(option) },
                            set: { isSelected in
                                if isSelected {
                                    selectedOptions.insert(option)
                                } else {
                                    selectedOptions.remove(option)
                                }
                            }
                        ))
                    }
                }
            }
            .navigationBarTitle("Filter")
            .navigationBarItems(
                leading: Button("Cancel") {
                    // Close the filter popup
                    isPresented = false
                },
                trailing: Button("Apply") {
                    // Apply the filter and close the filter popup
                    isPresented = false
                    // You can use the selectedOptions here to apply the filter
                    filterPriority = selectedOptions.first ?? "hard"
                }
            )
        }
    }
}

