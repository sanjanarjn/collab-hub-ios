//Copyright © 2021 Apple Inc. All rights reserved.

import Foundation
import SwiftUI


enum UserPreference {
    case domain
    case focusArea
    case language
}

//enum IssueType: String {
//    case bug = "bug"
//    case helpWanted = "help wanted"
//    case goodFirstIssue = "good first issue"
//    case improvement = "improvement"
//}

enum IssueType: String {
    case easy
    case medium
    case hard
}

class Utility {
    
//    static var items: [Issue] = [
//        Issue(name: "Bug in collection view", priority: "easy"),
//        Issue(name: "App crash", priority: "hard"),
//        Issue(name: "Web Service Issue", priority: "medium"),
//        Issue(name: "UI not loading properly", priority: "easy")
//    ]
    
    static var BlueTheme: Color {
        get {
            return Color("BlueTheme", bundle: nil)
        }
    }

    static func isCardSelected(_ card: Card, dataItem: DataItem) -> Bool {
        let domains = DataStore.sharedInstance.getValueForKey(dataItem)
        if domains.contains(card.title) {
            return true
        }
        
        return false
    }
    
    static func issueLabelColor(_ type: IssueType) -> Color {
        switch type {
        case .easy:
            return .green
        case .medium:
            return .orange
        case .hard:
            return .red
        }
    }
    
    static func fethcProjectsBasedonId(_ id: String) -> URL {
        let baseURL = "http://192.168.1.135:8080/collab-hub/home"
        let endpoint = "projects"

        let urlString = "\(baseURL)/\(id)/\(endpoint)"
        let url = URL(string: urlString)!
        return url
    }
    
    static func fethcIssuesBasedonId(_ id: String) -> URL {
        let baseURL = "http://192.168.1.135:8080/collab-hub/home"
        let endpoint = "issues"

        let urlString = "\(baseURL)/\(id)/\(endpoint)"
        let url = URL(string: urlString)!
        return url
    }
    
}

//Mock Issue and Project data

