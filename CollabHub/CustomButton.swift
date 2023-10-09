//Copyright © 2021 Apple Inc. All rights reserved.

import Foundation
import SwiftUI

struct CustomButton: View {
    var text: String
    var icon: Image?
    var clicked: (() -> Void)
    
    var body: some View {
        Button(action: clicked) { // call the closure here
            HStack {
                Text(text)
                    .fontWeight(.bold)// your text
                icon // your icon image
            }
            .frame(minWidth: 0, maxWidth: 400)
            .padding()
            .background(Utility.BlueTheme)
            .foregroundColor(.white)
            .cornerRadius(22)
        }
    }
}
