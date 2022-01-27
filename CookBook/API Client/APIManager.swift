//
//  APIManager.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import Foundation

public final class APIManager: APIClient {
    public func get(from url: URL, completion: @escaping (APIClient.Result) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data, let httpResponse = response as? HTTPURLResponse {
                completion(.success((data, httpResponse)))
            }
            else {
                let unknownError = NSError(domain: "Unknown Error", code: 0)
                completion(.failure(unknownError))
            }
        }
        .resume()
    }
}
