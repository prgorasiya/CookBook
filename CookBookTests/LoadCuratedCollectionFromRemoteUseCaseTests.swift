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

    func test_load_deliversConnectivityErrorOnClientError() {
        let (sut, client) = makeSUT()

        let clientError = NSError(domain: "Test", code: 0)

        let exp = expectation(description: "Wait for load completion")
        sut.load { result in
            switch result {
            case .failure(let receivedError):
                XCTAssertEqual(receivedError as! RemoteCuratedCollectionService.Error, RemoteCuratedCollectionService.Error.connectivity)

            default:
                XCTFail("Expected result \(clientError)")
            }
            exp.fulfill()
        }

        client.complete(with: clientError)

        waitForExpectations(timeout: 0.1)
    }

    func test_load_deliversInvalidDataErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500]
        let json = makeItemsJSON([])

        samples.enumerated().forEach { index, code in
            let exp = expectation(description: "Wait for load completion")
            
            sut.load { result in
                switch result {
                case .failure(let receivedError):
                    XCTAssertEqual(receivedError as! RemoteCuratedCollectionService.Error, RemoteCuratedCollectionService.Error.invalidData)

                default:
                    XCTFail("Expected result \(RemoteCuratedCollectionService.Error.invalidData)")
                }
                exp.fulfill()
            }
            client.complete(withStatusCode: code, data: json, at: index)
            waitForExpectations(timeout: 0.1)
        }
    }

    // MARK: - Helpers
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteCuratedCollectionService, client: APIClientSpy) {
        let client = APIClientSpy()
        let sut = RemoteCuratedCollectionService(url: url, client: client)
        return (sut, client)
    }

    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        return try! JSONSerialization.data(withJSONObject: items)
    }
}
