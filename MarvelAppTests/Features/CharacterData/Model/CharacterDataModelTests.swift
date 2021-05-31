//
//  CharacterDataModelTests.swift
//  MarvelAppTests
//
//  Created by Anna on 31/05/2021.
//

import XCTest
@testable import MarvelApp

class CharacterModelTests: XCTestCase {
    var model: CharacterDataWrapperModel?
    
    override func setUpWithError() throws {
        guard let path = Bundle(for: MarvelAppTests.self).path(forResource: "characters", ofType: "json") else {
            fatalError("Can't find search.json file")
        }

        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        model = try JSONDecoder().decode(CharacterDataWrapperModel.self, from: data)
    }
    
    override func tearDownWithError() throws {
        model = nil
    }
    
    func testDataWrapperModel() throws {
        XCTAssertEqual(model?.code, 200)
        XCTAssertEqual(model?.status, "Ok")
    }
    
    func testDataContainerModel() throws {
        let data = model?.data
        XCTAssertEqual(data?.offset, 0)
        XCTAssertEqual(data?.limit, 20)
        XCTAssertEqual(data?.total, 1493)
        XCTAssertEqual(data?.count, 20)
    }
    
    func testResultModel() throws {
        let result = model?.data?.results?[0]
        XCTAssertEqual(result?.id, 1009351)
        XCTAssertEqual(result?.name, "Hulk")
        XCTAssertEqual(result?.description, "Caught in a gamma bomb explosion while trying...")
    }
    
    func testURLModel() throws {
        let url = model?.data?.results?[0].urls?[0]
        XCTAssertEqual(url?.type, "detail")
        XCTAssertEqual(url?.url, "http://marvel.com/comics/characters/1009351/hulk?utm_campaign=apiRef&utm_source=094f916058b8fdbc86001eb904d98f29")
    }
    
    func testImageModel() throws {
        let image = model?.data?.results?[0].thumbnail
        XCTAssertEqual(image?.fileExtension, "jpg")
        XCTAssertEqual(image?.path, "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0")
    }
    
}
