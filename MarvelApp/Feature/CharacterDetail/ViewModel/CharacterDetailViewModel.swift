//
//  CharacterDetailViewModel.swift
//  MarvelApp
//
//  Created by Anna on 31/05/2021.
//

import Foundation

class CharacterDetailViewModel {
    private var characterModel: CharacterModel?
    
    var characterVM = CharacterViewModel()
    private func setCharacterDetail() {
        if let model = characterModel {
            let characterDataVM = CharacterViewModel()
            characterVM = characterDataVM.getCharacter(model)
        }
    }
    
    func setCharacterDetailModel(_ model: CharacterModel) {
        characterModel = model
        setCharacterDetail()
    }
    
}

// MARK: getData
extension CharacterDetailViewModel {
    
    func getData(characterId: Int,
                 success succeed: (@escaping () -> Void),
                 loadError fail: (@escaping () -> Void)) {
        let dataSource = CharacterDetailDataSource()
        dataSource.getResponse(characterId: characterId, success: { (result) in
            self.setCharacterDetailModel(result)
            succeed()
        }, failure: {
            fail()
        })
    }
    
}
