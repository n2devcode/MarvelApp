//
//  CharacterDataContainerDataSourceTests.swift
//  MarvelAppTests
//
//  Created by Anna on 31/05/2021.
//

import XCTest
@testable import MarvelApp

class CharacterDataContainerDataSourceTests: XCTestCase {
    
    func testResultSuccessDataSource(first: Int, success succeed: (@escaping (Bool, CharacterDataContainerModel?) -> Void)) {
        let characterListDS = CharacterDataContainerDataSource()
        characterListDS.getResponse(first: first) { (result) in
            succeed(true, result)
        } failure: {
            succeed(false, nil)
        }
    }
    
    func testGetResponse() {
        let exp = expectation(description: "Alamofire")
        testResultSuccessDataSource(first: 0, success: { (result, _) in
            XCTAssertTrue(result, "testResultSuccessDataSource returned false")
            exp.fulfill()
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetResponseIteratively() {
        let iterations = 5
        let num = 20
        
        var charactersList = [CharacterModel]()
        
        for index in (0..<iterations) {
            let first = index*num
            
            let exp = expectation(description: "AlamofireIteratively")
            
            testResultSuccessDataSource(first: first, success: { (result, data) in
                XCTAssertTrue(result, "testResultSuccessDataSource returned false")
                
                XCTAssertEqual(data?.offset, first, "returned results not equal to first")
                XCTAssertEqual(data?.limit, num, "returned results not equal to num")
                XCTAssertEqual(data?.total, 1493, "returned results not equal to 1493")
                XCTAssertEqual(data?.count, num, "returned results not equal to num")
                
                let characters = data?.results
                XCTAssertEqual(characters?.count, num, "returned results not equal to num")
                
                charactersList += characters ?? []
                XCTAssertEqual(charactersList.count, first+num, "returned results not equal to first+num")
                
                exp.fulfill()
            })
            
            waitForExpectations(timeout: 5.0, handler: nil)
        }
        
        XCTAssertEqual(charactersList.count, 100, "returned results not equal to 100")
    }
    
}
