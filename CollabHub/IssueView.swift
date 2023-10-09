//Copyright © 2021 Apple Inc. All rights reserved.

import SwiftUI

struct IssueView: View {
    var title: String
    var priority: String
    //var issueType: IssueType
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(Utility.BlueTheme)
                Spacer() 
//                Text(priority)
//                    .font(.body)
//                    .foregroundStyle(Utility.issueLabelColor(issueType))
            }
            .padding()
        }
}
