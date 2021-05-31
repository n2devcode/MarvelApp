//
//  CharacterViewModelTests.swift
//  MarvelAppTests
//
//  Created by Anna on 31/05/2021.
//

import XCTest
@testable import MarvelApp

class CharacterViewModelTests: XCTestCase {
    var characterVM = CharacterViewModel()
    
    var model: CharacterDataWrapperModel?

    override func setUpWithError() throws {
        guard let path = Bundle(for: MarvelAppTests.self).path(forResource: "characters", ofType: "json") else {
            fatalError("Can't find search.json file")
        }

        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        model = try JSONDecoder().decode(CharacterDataWrapperModel.self, from: data)
        
        if let dataContainer = model?.data,
           let result = dataContainer.results?.first {
            characterVM = characterVM.getCharacter(result)
        }
    }
    
    override func tearDownWithError() throws {
        model = nil
    }
    
    func testCharacterViewModel() throws {
        XCTAssertEqual(characterVM.characterId, 1009351)
        XCTAssertEqual(characterVM.name, "Hulk")
        XCTAssertEqual(characterVM.description, "Caught in a gamma bomb explosion while trying...")
        let firstURL = characterVM.urls.first
        XCTAssertEqual(firstURL?.type, TypeURLs.detail)
        XCTAssertEqual(firstURL?.url, "http://marvel.com/comics/characters/1009351/hulk?utm_campaign=apiRef&utm_source=094f916058b8fdbc86001eb904d98f29")
        XCTAssertEqual(characterVM.imageURLString, "https://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0.jpg")
    }
    
}
