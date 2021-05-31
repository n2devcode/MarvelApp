//
//  ViewController.swift
//  MarvelApp
//
//  Created by Anna on 31/05/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func clickShowCharacters(_ sender: Any) {
        if Utils.isConnectedToNetwork() {
            let characterListVC = CharacterListViewController()
            characterListVC.modalPresentationStyle = .fullScreen
            self.present(characterListVC, animated: true)
        } else {
            Utils.showAlert(self, description: "No tienes conexión a internet")
        }
    }
}
