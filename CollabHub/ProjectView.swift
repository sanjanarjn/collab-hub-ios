//Copyright © 2021 Apple Inc. All rights reserved.

import SwiftUI

struct ProjectView: View {
    var title: String
        var description: String
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(Utility.BlueTheme)
                Text(description)
                    .font(.body)
                    .lineLimit(5) // Limit to at most 5 lines
                Spacer() // Add spacer to push description to the bottom
            }
            .padding()
        }
}

#Preview {
    ProjectView(title: "Test", description: "This will provide the project description!")
}
