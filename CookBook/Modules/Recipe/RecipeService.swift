//
//  RecipeService.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import Foundation

public protocol RecipeService {
    typealias Result = Swift.Result<[Recipe], Error>

    func load(completion: @escaping (Result) -> Void)
}
