//
//  RecipeService.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import Foundation

public protocol RecipeService {
    typealias Result = Swift.Result<[Recipe], Error>
    var collectionId: Int! { get set }
    func load(completion: @escaping (Result) -> Void)
}
