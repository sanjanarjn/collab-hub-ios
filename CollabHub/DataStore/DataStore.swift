//Copyright © 2021 Apple Inc. All rights reserved.

import Foundation
import SwiftUI

enum DataItem: String {
    case emailId = "emailId"
    case domain = "domain"
    case focusArea = "focusArea"
    case language = "language"
    case uniqueId = "uniqueId"
    
    var propertyName: String {
        switch self {
        case .emailId:
            return "emailId"
        case .domain:
            return "domain"
        case .focusArea:
            return "focusArea"
        case .language:
            return "language"
        case .uniqueId:
            return "uniqueId"
        }
    }
}

class DataStore {
    
    static let sharedInstance = DataStore()
    private init() {}
    
    var projects: [Project]?
    var issues: [Issue]?
    
    @AppStorage(DataItem.emailId.rawValue) var emailId: String = ""
    @AppStorage(DataItem.domain.rawValue) var domain: String = ""
    @AppStorage(DataItem.focusArea.rawValue) var focusArea: String = ""
    @AppStorage(DataItem.language.rawValue) var language: String = ""
    
    //Save the id returned by the server after posting the data. This should be used for fetching the projects and issues.
    @AppStorage(DataItem.uniqueId.rawValue) var uniqueId: String = ""
    
    func setValueForKey(_ key: DataItem, value: String) {
        switch key {
        case .emailId:
            emailId = value
        case .domain:
            domainAppend(value)
        case .focusArea:
            focusAreaAppend(value)
        case .language:
            languageAppend(value)
        case .uniqueId:
            uniqueId = value
        }
    }
    
    func getValueForKey(_ key: DataItem) -> String {
        switch key {
        case .emailId:
            return emailId
        case .domain:
            return domain
        case .focusArea:
            return focusArea
        case .language:
            return language
        case .uniqueId:
            return uniqueId
        }
    }
    
    func getdataItemTypeFromPreference(_ value: UserPreference) -> DataItem {
        switch value {
        case .domain:
            return .domain
        case .focusArea:
            return .focusArea
        case .language:
            return .language
        }
    }
    
    func getIdForDomain(_ domain: String) -> Int {
        switch domain {
        case "Science":
            return 1
        case "Health & Fitness":
            return 2
        case "Gaming":
            return 3
        case "Finance":
            return 4
        case "Commerce":
            return 5
        case "Environment":
            return 6
        default:
            return -1
        }
    }
    
    func getIdForFocusArea(_ area: String) -> Int {
        switch area {
        case "Web Applications":
            return 1
        case "Backend Development":
            return 2
        case "Mobile Applications":
            return 3
        default:
            return -1
        }
    }
    
    func getIdForLanguage(_ language: String) -> Int {
        switch language {
        case "NodeJS":
            return 1
        case "Java":
            return 2
        case "Go":
            return 3
        case "Javascript":
            return 4
        case "Python":
            return 5
        case "Swift":
            return 6
        default:
            return -1
        }
    }
    
    private func domainAppend(_ value: String) {
        var currentDomain = UserDefaults.standard.string(forKey: DataItem.domain.rawValue) ?? ""
        
        if !currentDomain.isEmpty {
            currentDomain += ","
        }
        currentDomain += value
        UserDefaults.standard.set(currentDomain, forKey: DataItem.domain.rawValue)
        domain = currentDomain
    }
    
    private func focusAreaAppend(_ value: String) {
        var currentFocusArea = UserDefaults.standard.string(forKey: DataItem.focusArea.rawValue) ?? ""
        if !currentFocusArea.isEmpty {
            currentFocusArea += ","
        }
        currentFocusArea += value
        UserDefaults.standard.set(currentFocusArea, forKey: DataItem.focusArea.rawValue)
        focusArea = currentFocusArea
    }
    
    private func languageAppend(_ value: String) {
        var currentLanguage = UserDefaults.standard.string(forKey: DataItem.language.rawValue) ?? ""
        
        if !currentLanguage.isEmpty {
            currentLanguage += ","
        }
        currentLanguage += value
        UserDefaults.standard.set(currentLanguage, forKey: DataItem.language.rawValue)
        language = currentLanguage
    }
    
    func getValuesFrom(_ string: String) -> [String] {
        return string.components(separatedBy: ",")
    }
    
    func buildUserProfile() -> Preference {
        
        var domainArray = [PreferenceItem]()
        let selectedDomains = getValuesFrom((DataStore.sharedInstance.getValueForKey(.domain)))
        
        for domain in selectedDomains {
            let domain = PreferenceItem(id: getIdForDomain(domain))
            domainArray.append(domain)
        }
        
        var focusAreaArray = [PreferenceItem]()
        let selectedFocusAreas = getValuesFrom((DataStore.sharedInstance.getValueForKey(.focusArea)))
        
        for area in selectedFocusAreas {
            let area = PreferenceItem(id: getIdForFocusArea(area))
            focusAreaArray.append(area)
        }
        
        
        var technologyArray = [PreferenceItem]()
        let technologies = getValuesFrom((DataStore.sharedInstance.getValueForKey(.language)))
        
        for technology in technologies {
            let technology = PreferenceItem(id: getIdForLanguage(technology))
            technologyArray.append(technology)
        }
        
        let preferences = Preferences(with: domainArray, focusArea: focusAreaArray, technology: technologyArray)

        
        let userPreference = Preference(email: DataStore.sharedInstance.getValueForKey(.emailId), preferences: preferences)
        
        return userPreference
        
    }
    
    func getProjectsFortheUser(completion: @escaping ([Project]?, Error?) -> Void) {
        let url =  Utility.fethcProjectsBasedonId(DataStore.sharedInstance.getValueForKey(.uniqueId))
        NetworkService().fetchData(url: url) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.projects = response
                    completion(response, nil)
                case .failure(let failure):
                    completion(nil, failure)
                }
            }
    }
    
    func getIssuesFortheUser(completion: @escaping ([Issue]?, Error?) -> Void) {
        let url =  Utility.fethcIssuesBasedonId(DataStore.sharedInstance.getValueForKey(.uniqueId))
        NetworkService().fetchIssueData(url: url) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.issues = response
                    completion(response, nil)
                case .failure(let failure):
                    completion(nil, failure)
                }
            }
    }
}
