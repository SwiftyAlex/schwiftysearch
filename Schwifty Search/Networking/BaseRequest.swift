//
//  BaseRequest.swift
//  Schwifty Search
//
//  Created by Alex Logan on 22/01/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import UIKit

class BaseRequest: NSObject {
    
    typealias BaseCompletion<Object: Codable> = (Object?, Error?) -> ()
    
    func GET<Object: Codable>(url: String, params: [String: Any] = [:], object: Object.Type, completion: @escaping BaseCompletion<Object>) {
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = []
        for (key, value) in params {
            let queryItem = URLQueryItem(name: key, value: String(describing: value))
            urlComponents?.queryItems?.append(queryItem)
        }
        if let url = urlComponents?.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            self.addRequestHeaders(request: &request)
            return self.processRequest(request: request, completion: completion)
        } else {
            let requestError = NSError(domain: "co.uk.alexanderlogan", code: 404, userInfo: nil)
            completion(nil, requestError)
        }
    }
    
    func processRequest<Object: Codable>(request: URLRequest, completion: @escaping BaseCompletion<Object>) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let responseError = error {
                DispatchQueue.main.async {
                    completion(nil, responseError)
                }
            }
            if let response = response as? HTTPURLResponse, let data = data, 200...299 ~= response.statusCode {
                DispatchQueue.main.async {
                    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                        fatalError("Failed to retrieve context")
                    }
                    decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                    if let object = try? decoder.decode(Object.self, from: data){
                        completion(object, nil)
                        try! managedObjectContext.save()
                    } else {
                        let jsonError = NSError(domain: "co.uk.alexanderlogan", code: 404, userInfo: nil)
                        completion(nil, jsonError)
                    }
                }
            }
        }
        task.resume()
    }
    
    func addRequestHeaders(request: inout URLRequest) {
        var headers: [String: String] = [:]
        headers["Accept"] = "application/json"
        headers["Content-Type"] = "application/json"
        
        headers.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }
    }
}
