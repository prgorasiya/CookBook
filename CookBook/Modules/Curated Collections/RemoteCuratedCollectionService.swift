//
//  RemoteCuratedCollectionService.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import Foundation

public final class RemoteCuratedCollectionService: CuratedCollectionService {
    private let url = URL(string: "https://cookpad.github.io/global-mobile-hiring/api/collections")!
    private let client: APIClient

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }

    public init(client: APIClient) {
        self.client = client
    }

    public func load(completion: @escaping (CuratedCollectionService.Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }

            switch result {
            case let .success((data, response)):
                guard response.statusCode == 200, let collection = try? RemoteCuratedCollectionMapper.curatedCollection(from: data) else {
                    completion(.failure(Error.invalidData))
                    return
                }
                completion(.success(collection))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}
