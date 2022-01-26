//
//  RemoteCuratedCollectionMapper.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import Foundation

enum RemoteCuratedCollectionMapper {
    private struct Root: Decodable {
        let items: [Item]
    }
    
    private struct Item: Decodable {
        let id: Int
        let title: String
        let description: String
        let recipeCount: Int
        let previewImageUrls: [String]

        var item: CuratedCollection {
            return CuratedCollection(id: id,
                                           title: title,
                                           description: description,
                                           recipeCount: recipeCount,
                                           previewImageUrls: previewImageUrls)
        }
    }

    static func curatedCollection(from data: Data) throws -> [CuratedCollection] {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode(Root.self, from: data).items.map({ $0.item })
    }
}
