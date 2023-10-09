//Copyright © 2021 Apple Inc. All rights reserved.

import SwiftUI

struct HomeView: View {
    @State private var isFilterSheetPresented = false
            
    var body: some View {
            TabView {
                Tab1View()
                    .tabItem {
                        Image(systemName: "doc.on.doc.fill")
                        Text("Projects")
                    }
                Tab2View()
                    .tabItem {
                        Image(systemName: "exclamationmark.circle")
                        Text("Issues")
                    }
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            .navigationBarHidden(true)
        }
}

struct Tab1View: View {
    
        
    var projects: [Project] = DataStore.sharedInstance.projects!

    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects) { project in
                    NavigationLink(destination: WebView(urlString: project.url ?? "https://www.github.com")) {
                        ProjectView(title: project.name , description: project.description ?? "")
                    }
                }
            }
            .navigationTitle("Projects")
            .scrollContentBackground(.hidden)
        }
    }
}

struct Tab2View: View {
    @State private var isFilterSheetPresented = false
    
    @State private var filterPriority = "hard"
    
    //var issues: [Project] = DataStore.sharedInstance.projects!
    var issues: [Issue] = DataStore.sharedInstance.issues!

        var filteredIssues: [Issue] {
            if filterPriority == "All" {
                return issues
            } else {
                return issues.filter { $0.priority == filterPriority }
            }
        }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(issues) { item in
                    NavigationLink(destination: WebView(urlString: "https://www.github.com")) {
                        IssueView(title: item.title, priority: item.priority)
                    }
                }
            }
            .navigationTitle("Issues")
            .scrollContentBackground(.hidden)
            .navigationBarItems(
                trailing: Button(action: {
                    // Show the filter sheet when the button is clicked
                    isFilterSheetPresented.toggle()
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .imageScale(.large)
                }
            )
        }
        .sheet(isPresented: $isFilterSheetPresented) {
            // This is the filter popup content
            FilterPopupView(isPresented: $isFilterSheetPresented, filterPriority: $filterPriority)
        }
    }
}

struct Tab3View: View {
    var body: some View {
            List {
                Text("Item X")
                Text("Item Y")
                Text("Item Z")
            }
            .navigationTitle("Tab 3")
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListRowHeight, 50)
        }
}

#Preview {
    HomeView()
}
