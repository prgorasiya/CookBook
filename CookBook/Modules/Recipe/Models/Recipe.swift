//
//  Recipe.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import Foundation

public struct Recipe: Hashable {
    public let id: Int
    public let title: String
    public let story: String
    public let imageUrl: String?
    public let user: User
    public let ingredients: [String]
    public let steps: [Step]
}

public struct User: Hashable {
    public let name: String
    public let imageUrl: String?
}

public struct Step: Hashable {
    public let description: String
    public let imageUrls: [String]
}
