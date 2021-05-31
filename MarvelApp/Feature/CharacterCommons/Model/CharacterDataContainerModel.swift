//
//  CharacterDataContainerModel.swift
//  MarvelApp
//
//  Created by Anna on 31/05/2021.
//

import Foundation

struct CharacterDataContainerModel: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [CharacterModel]?
}
