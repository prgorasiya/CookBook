//
//  CuratedCollectionService.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import Foundation

public protocol CuratedCollectionService {
    typealias Result = Swift.Result<[CuratedCollection], Error>

    func load(completion: @escaping (Result) -> Void)
}
