//
//  APIClient.swift
//  AEUrlLoader
//
//  Created by Ajumal Ebrahim on 11/23/18.
//  Copyright © 2018 Ajumal Ebrahim. All rights reserved.
//

import Foundation

public class APIClient {
    public init() { }
    
    public func get(_ url: URL, onSuccess success: @escaping (_ data: Data) -> Void, onFailure failure: @escaping (_ error: Error?) -> Void) {
        // Set up the URL request

        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                failure(error)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                failure(error)
                return
            }
            
            success(responseData)
        }
        task.resume()
    }
    
    func post(_ url: String, _ param: [String: Any], onSuccess success: @escaping (_ data: Data) -> Void, onFailure failure: @escaping (_ error: Error?) -> Void) {
        guard let endpoint = URL(string: url) else {
            return
        }
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        let jsonData: Data
        do {
            jsonData = try JSONSerialization.data(withJSONObject: param, options: [])
            urlRequest.httpBody = jsonData
        } catch {
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard error == nil else {
                failure(error)
                return
            }
            guard let responseData = data else {
                failure(error)
                return
            }
            success(responseData)
        
        }
        task.resume()
    }
}
