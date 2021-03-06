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
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: CuratedCollection, rhs: CuratedCollection) -> Bool {
        return lhs.id == rhs.id
    }
}
