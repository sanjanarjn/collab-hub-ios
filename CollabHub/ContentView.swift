//Copyright © 2021 Apple Inc. All rights reserved.

import SwiftUI

struct ContentView: View {
    @State var emailId: String = DataStore.sharedInstance.getValueForKey(.emailId)
    @State private var emailIdPresent = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Let's start creating your profile...")
                    .font(.system(size: 56))
                    .foregroundColor(Utility.BlueTheme)
                    .padding()
                TextField("Enter your email Id", text: $emailId)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Utility.BlueTheme, lineWidth: 2)
                    )
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .autocapitalization(.none) 
                CustomButton(text: "Next") {
                    if !emailId.isEmpty {
                        DataStore.sharedInstance.setValueForKey(.emailId, value: emailId)
                        emailIdPresent = true
                    }
                }
                
                NavigationLink("", destination: CategoryView(),
                               isActive: $emailIdPresent)
                
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
