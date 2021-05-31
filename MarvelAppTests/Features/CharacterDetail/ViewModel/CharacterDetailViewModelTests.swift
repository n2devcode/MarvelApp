//
//  CharacterDetailViewModelTests.swift
//  MarvelAppTests
//
//  Created by Anna on 31/05/2021.
//

import XCTest
@testable import MarvelApp

class CharacterDetailViewModelTests: XCTestCase {
    let characterDetailVM = CharacterDetailViewModel()
    
    var model: CharacterDataWrapperModel?

    override func setUpWithError() throws {
        guard let path = Bundle(for: MarvelAppTests.self).path(forResource: "characterDetail", ofType: "json") else {
            fatalError("Can't find search.json file")
        }

        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        model = try JSONDecoder().decode(CharacterDataWrapperModel.self, from: data)
        
        if let dataContainer = model?.data,
           let result = dataContainer.results,
           let detail = result.first {
            characterDetailVM.setCharacterDetailModel(detail)
        }
    }

    override func tearDownWithError() throws {
        model = nil
    }

    func testCharacterViewModel() throws {
        let characterDetail = self.characterDetailVM.characterVM
        XCTAssertEqual(characterDetail.characterId, 1009351)
        XCTAssertEqual(characterDetail.name, "Hulk")
        XCTAssertEqual(characterDetail.description, "Caught in a gamma bomb explosion while trying...")
        let firstURL = characterDetail.urls.first
        XCTAssertEqual(firstURL?.type, TypeURLs.detail)
        XCTAssertEqual(firstURL?.url, "http://marvel.com/comics/characters/1009351/hulk?utm_campaign=apiRef&utm_source=094f916058b8fdbc86001eb904d98f29")
        XCTAssertEqual(characterDetail.imageURLString, "https://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0.jpg")
    }
    
}
