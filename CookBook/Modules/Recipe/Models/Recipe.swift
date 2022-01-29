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
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }
}

public struct User: Hashable {
    public let name: String
    public let imageUrl: String?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name
    }
}

public struct Step: Hashable {
    public let description: String
    public let imageUrls: [String]
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }
    
    public static func == (lhs: Step, rhs: Step) -> Bool {
        return lhs.description == rhs.description
    }
}
