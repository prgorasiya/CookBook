//
//  RemoteRecipeMapper.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import Foundation

enum RemoteRecipeMapper {
    private struct Item: Decodable {
        let id: Int
        let title: String
        let story: String
        let imageUrl: String?
        let user: LocalUser
        let ingredients: [String]
        let steps: [LocalStep]

        var item: Recipe {
            return Recipe(id: id,
                          title: title,
                          story: story,
                          imageUrl: imageUrl ?? "",
                          user: user.item,
                          ingredients: ingredients,
                          steps: steps.map({ $0.item })
            )
        }
    }

    static func recipes(from data: Data) throws -> [Recipe] {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode([Item].self, from: data).map({ $0.item })
    }
}

private struct LocalUser: Decodable {
    let name: String
    let imageUrl: String?

    var item: User {
        return User(name: name, imageUrl: imageUrl)
    }
}

private struct LocalStep: Decodable {
    let description: String
    let imageUrls: [String]

    var item: Step {
        return Step(description: description, imageUrls: imageUrls)
    }
}
