//
//  CharacterDetailDataSourceTests.swift
//  MarvelAppTests
//
//  Created by Anna on 31/05/2021.
//

import XCTest
@testable import MarvelApp

class CharacterDetailDataSourceTests: XCTestCase {
    
    func testResultSuccessDataSource(characterId: Int, success succeed: (@escaping (Bool, CharacterModel?) -> Void)) {
        let dataSource = CharacterDetailDataSource()
        dataSource.getResponse(characterId: characterId) { (result) in
            succeed(true, result)
        } failure: {
            succeed(false, nil)
        }
    }
    
    func testGetResponse() {
        let exp = expectation(description: "Alamofire")
        testResultSuccessDataSource(characterId: 1009351, success: { (result, _) in
            XCTAssertTrue(result, "testResultSuccessDataSource returned false")
            exp.fulfill()
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
