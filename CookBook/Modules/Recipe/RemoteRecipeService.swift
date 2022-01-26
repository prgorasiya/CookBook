//
//  RemoteRecipeService.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import Foundation

public final class RemoteRecipeService: RecipeService {
    private let url: URL
    private let client: APIClient

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }

    public init(url: URL, client: APIClient) {
        self.url = url
        self.client = client
    }

    public func load(completion: @escaping (RecipeService.Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }

            switch result {
            case let .success((data, response)):
                guard response.statusCode == 200, let images = try? RemoteRecipeMapper.recipes(from: data) else {
                    completion(.failure(Error.invalidData))
                    return
                }
                completion(.success(images))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}
