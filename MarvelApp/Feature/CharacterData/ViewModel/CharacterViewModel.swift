//
//  CharacterViewModel.swift
//  MarvelApp
//
//  Created by Anna on 31/05/2021.
//

import Foundation
import UIKit

class CharacterViewModel {
    private var characterModel: CharacterModel?
    
    var id: Int {
        return characterModel?.id ?? Constants.noInt
    }
    
    var name: String {
        return characterModel?.name ?? Constants.noData
    }
    
    var description: String {
        return characterModel?.description ?? Constants.noData
    }
    
    var urls: [StructURLs] {
        var result = [StructURLs]()
        let arrayURL = characterModel?.urls
        arrayURL?.forEach({ (url) in
            let structURL = StructURLs(
                type: TypeURLs(rawValue: url.type ?? Constants.noData) ?? .unknown,
                url: url.url ?? Constants.noData
            )
            result.append(structURL)
        })
        return result
    }
    
    var imageURLString: String {
        if let thumbnail = characterModel?.thumbnail,
           let path = thumbnail.path,
           let fileExtension = thumbnail.fileExtension {
            return "\(path).\(fileExtension)".secureURL()
        }
        return Constants.noData
    }
    
    init() { }
    
    private init(model: CharacterModel) {
        characterModel = model
    }
    
    func getCharacter(_ result: CharacterModel) -> CharacterViewModel {
        return CharacterViewModel(model: result)
    }
}

struct StructURLs {
    let type: TypeURLs
    let url: String
}

enum TypeURLs: String {
    case comiclink
    case wiki
    case detail
    case unknown
}
