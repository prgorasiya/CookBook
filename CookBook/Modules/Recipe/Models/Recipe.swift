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
    public let user: User?
    public let ingredients: [String]
    public let steps: [Step]

    public init(id: Int, title: String, story: String, imageUrl: String, user: User, ingredients: [String], steps: [Step]) {
        self.id = id
        self.title = title
        self.story = story
        self.imageUrl = imageUrl
        self.user = user
        self.ingredients = ingredients
        self.steps = steps
    }
}

public struct User: Hashable {
    public let name: String
    public let imageUrl: String?

    public init(name: String, imageUrl: String?) {
        self.name = name
        self.imageUrl = imageUrl
    }
}

public struct Step: Hashable {
    public let description: String
    public let imageUrls: [String]

    public init(description: String, imageUrls: [String]) {
        self.description = description
        self.imageUrls = imageUrls
    }
}
