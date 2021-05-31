//
//  CharacterModel.swift
//  MarvelApp
//
//  Created by Anna on 31/05/2021.
//

import Foundation

struct CharacterModel: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let urls: [URLModel]?
    let thumbnail: ImageModel?
}
