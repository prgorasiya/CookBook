//
//  LoadCuratedCollectionFromRemoteUseCaseTests+Helpers.swift
//  CookBookTests
//
//  Created by paras gorasiya on 28/01/22.
//

import XCTest

extension LoadCuratedCollectionFromRemoteUseCaseTests {
    func expect(_ sut: RemoteCuratedCollectionService,
                toCompleteWith expectedResult: Result<[CuratedCollection], RemoteCuratedCollectionService.Error>,
                when action: () -> Void,
                file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
                
            case let (.failure(receivedError as RemoteCuratedCollectionService.Error), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
                
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        action()
        
        waitForExpectations(timeout: 0.1)
    }
}
