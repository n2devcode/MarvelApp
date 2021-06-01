//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by Anna on 01/06/2021.
//

import UIKit

class CharacterDetailViewController: BaseViewController {
    @IBOutlet weak var characterDetailNameLabel: UILabel!
    @IBOutlet weak var characterDetailView: UIView!
    
    let characterDetailVM = CharacterDetailViewModel()
    var characterId = 0
    
    @IBAction func dismissBack(_ sender: Any) {
        gotoBack()
    }
    
    override func loadData() {
        showLoadView()
        characterDetailVM.getData(characterId: characterId) {
            self.showCharacterTableView()
        } loadError: {
            self.showErrorView()
        }
    }
    
    override func showLoadView() {
        if let subview = self.loadView("LoadView") as? LoadView {
            self.addSubview(view: characterDetailView, subview: subview)
        }
    }
    
    override func showErrorView() {
        if let subview = self.loadView("ErrorView") as? ErrorView {
            subview.characterVC = self
            self.addSubview(view: characterDetailView, subview: subview)
        }
    }
    
    private func showCharacterTableView() {
        if let subview = self.loadView("CharacterDetailView") as? CharacterDetailView {
            self.addSubview(view: characterDetailView, subview: subview)
        }
    }
    
}
