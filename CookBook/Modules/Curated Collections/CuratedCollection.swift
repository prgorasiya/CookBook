//
//  CuratedCollection.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import Foundation

public struct CuratedCollection: Hashable {
    public let id: Int
    public let title: String
    public let description: String
    public let recipeCount: Int
    public let previewImageUrls: [String]

    public init(id: Int, title: String, description: String, recipeCount: Int, previewImageUrls: [String]) {
        self.id = id
        self.title = title
        self.description = description
        self.recipeCount = recipeCount
        self.previewImageUrls = previewImageUrls
    }
}
