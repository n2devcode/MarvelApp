//
//  CharacterDataContainerViewModel.swift
//  MarvelApp
//
//  Created by Anna on 31/05/2021.
//

import Foundation

class CharacterDataContainerViewModel {
    private var dataContainerModel: CharacterDataContainerModel?
    
    var characterListVM = [CharacterViewModel]()
    private func appendCharacterList() {
        let characterVM = CharacterViewModel()
        for characterModel in (dataContainerModel?.results ?? []) {
            let character = characterVM.getCharacter(characterModel)
            characterListVM.append(character)
        }
    }
    
    var offset: Int {
        return dataContainerModel?.offset ?? Constants.noInt
    }
    
    var limit: Int {
        return dataContainerModel?.limit ?? Constants.noInt
    }
    
    var total: Int {
        return dataContainerModel?.total ?? Constants.noInt
    }
    
    var count: Int {
        return dataContainerModel?.count ?? Constants.noInt
    }
    
    func setCharacterModel(_ model: CharacterDataContainerModel) {
        dataContainerModel = model
        appendCharacterList()
    }
    
}

// MARK: getData
extension CharacterDataContainerViewModel {
    
    func getData(first: Int = 0,
                 success succeed: (@escaping () -> Void),
                 loadError fail: (@escaping () -> Void)) {
        let dataSource = CharacterDataContainerDataSource()
        dataSource.getResponse(first: first, success: { (result) in
            if first == 0 {
                self.characterListVM = [CharacterViewModel]()
            }
            self.setCharacterModel(result)
            succeed()
        }, failure: {
            fail()
        })
    }
    
}
