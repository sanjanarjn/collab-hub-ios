//Copyright © 2021 Apple Inc. All rights reserved.

import SwiftUI

struct LanguageView: View {
    @State var selected: Bool = false
    
        var columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    
        let height: CGFloat = 150
        let cards: [Card] = MockStore.languageCards
        
        var body: some View {
                HStack {
                    Text("Tech it Up - Choose your tool")
                        .font(.system(size: 28))
                        .foregroundColor(Utility.BlueTheme)
                    Spacer()
                }
                
                ScrollView {
                    // 4. Populate into grid
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(cards) { card in
                            CardView(title: card.title, iconName: card.iconName, type: .language, isChecked: Utility.isCardSelected(card, dataItem: .language))
                                .frame(height: height)
                        }
                    }
                    .padding()
                }
                
                Spacer()
                CustomButton(text: "Finish") {
                    let userProfile = DataStore.sharedInstance.buildUserProfile()
                    NetworkService().sendUserPreferenceToServer(userProfile) { result in
                        if result {
                            DataStore.sharedInstance.getProjectsFortheUser { result, error in
                                    
                                DataStore.sharedInstance.getIssuesFortheUser { result, error in
                                    debugPrint("Issue response received")
                                    selected = true
                                }
                            }
                        }
                    }
                }
                
                NavigationLink("", destination: HomeView(),
                                       isActive: $selected)
        }
}

#Preview {
    LanguageView()
}
