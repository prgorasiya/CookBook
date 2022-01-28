//
//  LoadCuratedCollectionFromRemoteUseCaseTests.swift
//  CookBookTests
//
//  Created by paras gorasiya on 28/01/22.
//

import XCTest

class LoadCuratedCollectionFromRemoteUseCaseTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()

        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT()

        sut.load { _ in }
        sut.load { _ in }

        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    // MARK: - Helpers
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteCuratedCollectionService, client: APIClientSpy) {
        let client = APIClientSpy()
        let sut = RemoteCuratedCollectionService(url: url, client: client)
        return (sut, client)
    }
}
