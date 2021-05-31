//
//  CharacterListViewController.swift
//  MarvelApp
//
//  Created by Anna on 31/05/2021.
//

import UIKit

class CharacterListViewController: UIViewController {
    @IBOutlet weak var characterListView: UIView!
    
    let characterDataContainerVM = CharacterDataContainerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    @IBAction func clickBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func loadData() {
        showLoadView()
        characterDataContainerVM.getData {
            self.showCharacterTableView()
        } loadError: {
            self.showErrorView()
        }
    }
    
}

extension CharacterListViewController: LoadViewProtocol, AddSubviewConstraintsProtocol {
    private func showLoadView() {
        if let subview = self.loadView("LoadView") as? LoadView {
            self.addSubview(view: characterListView, subview: subview)
        }
    }
    
    private func showErrorView() {
        if let subview = self.loadView("ErrorView") as? ErrorView {
            subview.characterListVC = self
            self.addSubview(view: characterListView, subview: subview)
        }
    }
    
    private func showCharacterTableView() {
        if let subview = self.loadView("CharacterTableView") as? CharacterTableView {
            subview.characterListVC = self
            self.addSubview(view: characterListView, subview: subview)
        }
    }
}
