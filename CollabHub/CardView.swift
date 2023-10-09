//Copyright © 2021 Apple Inc. All rights reserved.

import SwiftUI

struct CardView: View {
    let title: String
    let iconName: String
    var type: UserPreference
    @State var isChecked = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Utility.BlueTheme, lineWidth: 3)
                        .cornerRadius(12)
                        .foregroundColor(.white)
                    
                    VStack {
                        if type == .language {
                            Image(uiImage: UIImage(named: iconName)!)
                                .resizable()
                                .scaledToFit()
                                .padding()
                        } else {
                            Image(systemName: iconName)
                                .font(.largeTitle)
                                .foregroundColor(Utility.BlueTheme)
                        }
                        Text(title)
                            .font(.subheadline)
                            .foregroundColor(Utility.BlueTheme)
                    }
                    
                    Button(action: {
                        isChecked.toggle()
                        let key = DataStore.sharedInstance.getdataItemTypeFromPreference(type)
                        DataStore.sharedInstance.setValueForKey(key, value: title)
                        debugPrint("Title selected: \(title)")
                        debugPrint("Toggle Status: \(isChecked)")
                    }) {
                        ZStack {
                            Circle()
                                .stroke(Utility.BlueTheme, lineWidth: 2)
                                .frame(width: 25, height: 25)
                                .background(
                                    Circle()
                                        .fill(isChecked ? Utility.BlueTheme : Color.clear)
                                )
                            
                            if isChecked {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .position(x: geometry.size.width - 45, y: geometry.size.height - 145)
                    .padding(20)
                }
            }
            
        }
    }
}
