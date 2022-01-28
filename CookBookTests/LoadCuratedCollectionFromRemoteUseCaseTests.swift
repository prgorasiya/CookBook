//
//  LoadCuratedCollectionFromRemoteUseCaseTests.swift
//  CookBookTests
//
//  Created by paras gorasiya on 28/01/22.
//

import XCTest

class LoadCuratedCollectionFromRemoteUseCaseTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = APIClientSpy()

        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let client = APIClientSpy()
        let sut = RemoteCuratedCollectionService(url: url, client: client)

        sut.load { _ in }
        sut.load { _ in }

        XCTAssertEqual(client.requestedURLs, [url, url])
    }
}
