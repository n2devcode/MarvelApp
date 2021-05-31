//
//  ImageModel.swift
//  MarvelApp
//
//  Created by Anna on 31/05/2021.
//

import Foundation

struct ImageModel: Codable {
    let fileExtension: String?
    let path: String?
    
    enum CodingKeys: String, CodingKey {
        case fileExtension = "extension"
        case path = "path"
    }
}
