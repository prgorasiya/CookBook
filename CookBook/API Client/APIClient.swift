//
//  APIClient.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import Foundation

public protocol APIClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    func get(from url: URL, completion: @escaping (Result) -> Void)
}
