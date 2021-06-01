//
//  CharacterDetailURLTableViewCell.swift
//  MarvelApp
//
//  Created by Anna on 01/06/2021.
//

import UIKit

class CharacterDetailURLTableViewCell: UITableViewCell {
    @IBOutlet weak var characterDetailURLButton: UIButton!
    
    var characterDetailVC = CharacterDetailViewController()
    var url = StructURLs(type: .unknown, url: Constants.noData) {
        didSet {
            characterDetailURLButton.setTitle(url.type.rawValue, for: .normal)
        }
    }
    
    @IBAction func clickCharacterDetailURL(_ sender: Any) {
        if let valueURL = URL(string: url.url), UIApplication.shared.canOpenURL(valueURL) {
            UIApplication.shared.open(valueURL)
        } else {
            Utils.showAlert(characterDetailVC, description: "No podemos abrir la página")
        }
    }
    
}
