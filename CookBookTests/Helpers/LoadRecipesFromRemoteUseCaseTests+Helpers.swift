//
//  LoadRecipesFromRemoteUseCaseTests+Helpers.swift
//  CookBookTests
//
//  Created by paras gorasiya on 28/01/22.
//

import XCTest

extension LoadRecipesFromRemoteUseCaseTests {
    func expect(_ sut: RemoteRecipeService,
                toCompleteWith expectedResult: Result<[Recipe], RemoteRecipeService.Error>,
                when action: () -> Void,
                file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
                
            case let (.failure(receivedError as RemoteRecipeService.Error), .failure(expectedError)):
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
