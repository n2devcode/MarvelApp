//
//  CharacterDataContainerViewModelTests.swift
//  MarvelAppTests
//
//  Created by Anna on 31/05/2021.
//

import XCTest
@testable import MarvelApp

class CharacterDataContainerViewModelTests: XCTestCase {
    let characterListVM = CharacterDataContainerViewModel()
    
    var model: CharacterDataWrapperModel?

    override func setUpWithError() throws {
        guard let path = Bundle(for: MarvelAppTests.self).path(forResource: "characters", ofType: "json") else {
            fatalError("Can't find search.json file")
        }

        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        model = try JSONDecoder().decode(CharacterDataWrapperModel.self, from: data)
        
        if let dataContainer = model?.data {
            characterListVM.setCharacterModel(dataContainer)
        }
    }
    
    override func tearDownWithError() throws {
        model = nil
    }
    
    func testCharacterListViewModel() throws {
        XCTAssertEqual(self.characterListVM.offset, 0)
        XCTAssertEqual(self.characterListVM.limit, 20)
        XCTAssertEqual(self.characterListVM.total, 1493)
        XCTAssertEqual(self.characterListVM.count, 20)
    }
    
    func testCharacterViewModel() throws {
        let firstCharacter = self.characterListVM.characterListVM.first
        XCTAssertEqual(firstCharacter?.characterId, 1009351)
        XCTAssertEqual(firstCharacter?.name, "Hulk")
        XCTAssertEqual(firstCharacter?.description, "Caught in a gamma bomb explosion while trying...")
        let firstURL = firstCharacter?.urls.first
        XCTAssertEqual(firstURL?.type, TypeURLs.detail)
        XCTAssertEqual(firstURL?.url, "http://marvel.com/comics/characters/1009351/hulk?utm_campaign=apiRef&utm_source=094f916058b8fdbc86001eb904d98f29")
        XCTAssertEqual(firstCharacter?.imageURLString, "https://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0.jpg")
    }
    
    func testCharacterNilViewModel() throws {
        let secondCharacter = self.characterListVM.characterListVM[1]
        XCTAssertEqual(secondCharacter.characterId, -1)
        XCTAssertEqual(secondCharacter.name, "-")
        XCTAssertEqual(secondCharacter.description, "-")
        let firstURL = secondCharacter.urls.first
        XCTAssertEqual(firstURL?.type, nil)
        XCTAssertEqual(firstURL?.url, nil)
        XCTAssertEqual(secondCharacter.imageURLString, "-")
    }
    
}
