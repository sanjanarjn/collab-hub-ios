//Copyright © 2021 Apple Inc. All rights reserved.

import SwiftUI

struct MockStore {
    static var cards = [
        Card(title: "Science", iconName: "moon.stars"),
        Card(title: "Health & Fitness", iconName: "figure.run"),
        Card(title: "Gaming", iconName: "gamecontroller"),
        Card(title: "Finance", iconName: "dollarsign.square"),
        Card(title: "Commerce", iconName: "cart"),
        Card(title: "Environment", iconName: "globe.europe.africa")
    ]
    
    static var languageCards = [
        Card(title: "NodeJS", iconName: "Nodejs"),
        Card(title: "Java", iconName: "Java"),
        Card(title: "Go", iconName: "Go"),
        Card(title: "Javascript", iconName: "Javascript"),
        Card(title: "Python", iconName: "Python"),
        Card(title: "Swift", iconName: "Swift")
    ]
    
    static var listCards = [
        Card(title: "Web Applications", iconName: "desktopcomputer"),
        Card(title: "Backend Development", iconName: "server.rack"),
        Card(title: "Mobile Applications", iconName: "iphone.gen1")
    ]
}

struct CategoryView: View {
    @State var selected: Bool = false
    
    // 1. Number of items will be display in row
        var columns: [GridItem] = [
           // GridItem(.flexible(minimum: 140)),
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
        // 2. Fixed height of card
        let height: CGFloat = 150
        // 3. Get mock cards data
        let cards: [Card] = MockStore.cards
        
        var body: some View {
                HStack {
                    Text("Pick Your Passion!")
                        .font(.system(size: 36))
                        .foregroundColor(Utility.BlueTheme)
                    Spacer()
                }
                
                ScrollView {
                    // 4. Populate into grid
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(cards) { card in
                            
                            CardView(title: card.title, iconName: card.iconName, type: .domain, isChecked: Utility.isCardSelected(card, dataItem: .domain))
                                .frame(height: height)
                        }
                    }
                    .padding()
                }
                
                Spacer()
                CustomButton(text: "Next") {
                    selected = true
                }
                
                NavigationLink("", destination: DomainView(),
                                       isActive: $selected)
        }
    
    private func isCardSelected(_ card: Card) -> Bool {
        let domains = DataStore.sharedInstance.getValueForKey(.domain)
        if domains.contains(card.title) {
           return true
        }
        
        return false
    }
}

#Preview {
    CategoryView()
}
