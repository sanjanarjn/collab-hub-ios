//Copyright © 2021 Apple Inc. All rights reserved.

import Foundation

struct Project: Codable, Identifiable {
    let id = UUID()
    let name: String
    let description: String?
    let url: String?
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case name, description, language
        case url = "html_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        language = try container.decodeIfPresent(String.self, forKey: .language)
    }
}

struct Issue: Identifiable, Codable {
    let id = UUID()
    let title: String
    let state: String?
    let labels: [Label]?
    let htmlUrl: String?
    var priority: String = "easy"
    
    enum CodingKeys: String, CodingKey {
        case title
        case state
        case labels
        case htmlUrl = "html_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        state = try container.decodeIfPresent(String.self, forKey: .state)
        labels = try container.decodeIfPresent([Label].self, forKey: .labels)
        htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
    }
    
    var issueType: IssueType {
        switch priority.lowercased() {
        case "easy":
            return .easy
        case "medium":
            return .medium
        case "hard":
            return .hard
        default:
            return .medium
        }
    }
}

struct Label: Codable {
    let name: String
}


struct Preference: Codable {
    let email: String
    let preferences: Preferences
    var id: Int?
}

struct Preferences: Codable {
    let domain: [PreferenceItem]
    let focusArea: [PreferenceItem]
    let technology: [PreferenceItem]
    
    enum CodingKeys: String, CodingKey {
            case domain = "DOMAIN"
            case focusArea = "FOCUS_AREA"
            case technology = "TECHNOLOGY"
        }
    
    // You can customize the decoding logic if needed
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        domain = try container.decode([PreferenceItem].self, forKey: .domain)
        focusArea = try container.decode([PreferenceItem].self, forKey: .focusArea)
        technology = try container.decode([PreferenceItem].self, forKey: .technology)
    }

    // You can customize the encoding logic if needed
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(domain, forKey: .domain)
        try container.encode(focusArea, forKey: .focusArea)
        try container.encode(technology, forKey: .technology)
    }
    
    init(with domain: [PreferenceItem], focusArea: [PreferenceItem], technology: [PreferenceItem]) {
        self.domain = domain
        self.focusArea = focusArea
        self.technology = technology
    }
}

struct PreferenceItem: Codable {
    let id: Int
}
