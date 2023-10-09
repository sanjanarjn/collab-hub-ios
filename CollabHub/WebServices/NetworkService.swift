//Copyright © 2021 Apple Inc. All rights reserved.

import Foundation

import Foundation

class NetworkService {
//    func fetchData<T: Codable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                let error = NSError(domain: "YourAppErrorDomain", code: 0, userInfo: nil)
//                completion(.failure(error))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let result = try decoder.decode(T.self, from: data)
//                completion(.success(result))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
    
    func postData<T: Codable>(url: URL, data: Data, completion: @escaping (Result<T, Error>) -> Void) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    let error = NSError(domain: "YourAppErrorDomain", code: 0, userInfo: nil)
                    completion(.failure(error))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    
    func sendUserPreferenceToServer(_ preference: Preference, completion: @escaping (Bool) -> Void) {
            // Define the URL of the POST API endpoint
            guard let apiUrl = URL(string: "http://192.168.1.135:8080/collab-hub/user/preference") else {
                print("Invalid API URL")
                return
            }

            do {
                // Convert the request data to JSON data
                let jsonData = try JSONEncoder().encode(preference)

                // Call the postData method to make the POST request
                NetworkService().postData(url: apiUrl, data: jsonData) { (result: Result<Preference, Error>) in
                    switch result {
                    case .success(let response):
                        print("POST Request Successful: \(response.id)")
                        DataStore.sharedInstance.setValueForKey(.uniqueId, value: String(response.id ?? 0))
                        // Handle the successful response here
                        completion(true)

                    case .failure(let error):
                        print("POST Request Failed: \(error)")
                        // Handle the error here
                        completion(false)
                    }
                }
            } catch {
                print("Error converting request data to JSON: \(error)")
            }

    }
    
    func fetchData(url: URL, completion: @escaping (Result<[Project], Error>) -> Void) {
       
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "YourAppErrorDomain", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            do {
                do {
                    // Decode the JSON data into a Dictionary
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Response : \(json)")
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
                
                let decoder = JSONDecoder()
                let response = try decoder.decode([Project].self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchIssueData(url: URL, completion: @escaping (Result<[Issue], Error>) -> Void) {
       
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "YourAppErrorDomain", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            do {
                do {
                    // Decode the JSON data into a Dictionary
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Response : \(json)")
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
                
                let decoder = JSONDecoder()
                let response = try decoder.decode([Issue].self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}
