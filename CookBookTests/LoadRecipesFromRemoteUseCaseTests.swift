//
//  LoadRecipesFromRemoteUseCaseTests.swift
//  CookBookTests
//
//  Created by paras gorasiya on 28/01/22.
//

import XCTest

class LoadRecipesFromRemoteUseCaseTests: XCTestCase {
    private let path = "recipes"

    func test_init_doesNotRequestDataFromURL() {
        let collectionId = anyRandomCollectionId()
        let (_, client) = makeSUT(collectionId: collectionId)

        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_loadTwice_requestsDataFromURLTwice() {
        let collectionId = anyRandomCollectionId()
        var url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url, collectionId: collectionId)

        sut.load { _ in }
        sut.load { _ in }

        url = url.appendingPathComponent("\(collectionId)")
        url = url.appendingPathComponent(path)
        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliversConnectivityErrorOnClientError() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }

    func test_load_deliversInvalidDataErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500]

        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: .failure(.invalidData), when: {
                let json = makeItemsJSON([])
                client.complete(withStatusCode: code, data: json, at: index)
            })
        }
    }

    func test_load_deliversInvalidDataErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.invalidData), when: {
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        })
    }

    func test_load_deliversInvalidDataErrorOn200HTTPResponseWithPartiallyValidJSONItems() {
        let (sut, client) = makeSUT()

        let validItem = makeItem(
            id: anyRandomWholeNumber(),
            user: makeUser(),
            ingredients: ["Some ingredients"],
            steps: [makeStep()]
        ).json

        let invalidItem = [["invalid": "item"]]

        let items = validItem + invalidItem

        expect(sut, toCompleteWith: .failure(.invalidData), when: {
            let json = makeItemsJSON(items)
            client.complete(withStatusCode: 200, data: json)
        })
    }

    func test_load_deliversSuccessWithNoItemsOn200HTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .success([]), when: {
            let emptyListJSON = makeItemsJSON([])
            client.complete(withStatusCode: 200, data: emptyListJSON)
        })
    }

    func test_load_deliversSuccessWithItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()

        let item1 = makeItem(
            id: anyRandomWholeNumber(),
            user: makeUser(),
            ingredients: ["Some ingredients"],
            steps: [makeStep()])

        let item2 = makeItem(
            id: anyRandomWholeNumber(),
            title: "a title",
            story: "a story",
            user: makeUser(),
            ingredients: ["Some ingredients"],
            steps: [makeStep()])

        let items = [item1.model, item2.model]

        expect(sut, toCompleteWith: .success(items), when: {
            let array = item1.json + item2.json
            let json = makeItemsJSON(array)
            client.complete(withStatusCode: 200, data: json)
        })
    }

    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let url = URL(string: "http://any-url.com")!
        let client = APIClientSpy()
        var sut: RemoteCuratedCollectionService? = RemoteCuratedCollectionService(url: url, client: client)

        var capturedResults = [RemoteCuratedCollectionService.Result]()
        sut?.load { capturedResults.append($0) }

        sut = nil
        client.complete(withStatusCode: 200, data: makeItemsJSON([]))

        XCTAssertTrue(capturedResults.isEmpty)
    }

    // MARK: - Helpers
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!,
                         collectionId: Int? = nil,
                         file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteRecipeService, client: APIClientSpy) {
        let client = APIClientSpy()
        let sut = RemoteRecipeService(url: url, client: client)
        if let collectionId = collectionId {
            sut.collectionId = collectionId
        }
        else {
            sut.collectionId = anyRandomCollectionId()
        }
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(client, file: file, line: line)
        return (sut, client)
    }

    private func makeItem(id: Int,
                          title: String = "Any title",
                          story: String = "Any story",
                          imageUrl: String? = nil,
                          user: User,
                          ingredients: [String],
                          steps: [Step]) -> (model: Recipe, json: [[String: Any]]) {
        let item = Recipe(id: id, title: title, story: story, imageUrl: imageUrl, user: user, ingredients: ingredients, steps: steps)
        var stepsJson: [[String : Any]] = []
        steps.forEach { step in
            stepsJson.append(["description" : step.description, "image_urls" : step.imageUrls])
        }
        var object: [String : Any] = [
            "id": id,
            "title": title,
            "story": story,
            "user": ["name" : user.name, "image_url" : user.imageUrl],
            "ingredients": ingredients,
            "steps": stepsJson
        ]
        if let imageUrl = imageUrl {
            object["image_url"] = imageUrl
        }
        object = object.compactMapValues { $0 }

        let json = [object]

        return (item, json)
    }

    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        return try! JSONSerialization.data(withJSONObject: items)
    }

    private func makeUser() -> User {
        return User(name: "Any name", imageUrl: "https://a-url.com")
    }

    private func makeStep() -> Step {
        return Step(description: "Any description", imageUrls: [""])
    }

    private func anyRandomCollectionId() -> Int {
        Int.random(in: 1...7)
    }

    private func anyRandomWholeNumber() -> Int {
        Int.random(in: 1...1000)
    }
}
