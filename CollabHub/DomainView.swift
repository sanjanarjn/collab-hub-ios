//Copyright © 2021 Apple Inc. All rights reserved.

import SwiftUI

struct DomainView: View {
    
    let height: CGFloat = 75
    @State var isSelected: Bool = false
    
    var columns: [GridItem] = [
        GridItem(.flexible())
    ]

    let listCards: [Card] = MockStore.listCards
    
    var body: some View {
        VStack {
            Text("Set your Focus Area")
                .font(.system(size: 36))
                .foregroundColor(Utility.BlueTheme)
            Spacer()
            
            ScrollView {
                // 4. Populate into grid
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(listCards) { card in
                        ListView(title: card.title, iconName: card.iconName, type: .focusArea, isChecked: Utility.isCardSelected(card, dataItem: .focusArea))
                            .frame(height: height)
                    }
                }
                .padding()
            }
        }
        
        Spacer()
        CustomButton(text: "Next") {
            isSelected = true
        }
        
        NavigationLink("", destination: LanguageView(),
                               isActive: $isSelected)
    }
}

#Preview {
    DomainView()
}
