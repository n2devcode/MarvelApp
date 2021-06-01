//
//  CharacterDetailView.swift
//  MarvelApp
//
//  Created by Anna on 01/06/2021.
//

import UIKit

class CharacterDetailView: UIView {
    @IBOutlet weak var characterDetailImageView: UIImageView!
    @IBOutlet weak var characterDetailDescriptionLabel: UILabel!
    @IBOutlet weak var characterDetailURLTableView: UITableView!
    @IBOutlet weak var heightTableViewConstraint: NSLayoutConstraint!
    
    private let nibNameCell = "CharacterDetailURLTableViewCell"
    private let heightCell = CGFloat(50)
    
    var characterDetailVC = CharacterDetailViewController()
    var characterVM = CharacterViewModel() {
        didSet {
            loadDetail()
        }
    }
    
    private func loadDetail() {
        characterDetailImageView.loadImage(stringURL: characterVM.imageURLString)
        characterDetailDescriptionLabel.text = characterVM.description
        loadTableURLs()
    }
    
    private func loadTableURLs() {
        heightTableViewConstraint.constant = CGFloat(characterVM.urls.count)*heightCell
        registerNib()
        setDelegates()
    }
    
    private func registerNib() {
        let nib = UINib(nibName: nibNameCell, bundle: Bundle.main)
        characterDetailURLTableView.register(nib, forCellReuseIdentifier: nibNameCell)
    }
    
    private func setDelegates() {
        characterDetailURLTableView.dataSource = self
        characterDetailURLTableView.delegate = self
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension CharacterDetailView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterVM.urls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: nibNameCell, for: indexPath) as? CharacterDetailURLTableViewCell {
            cell.characterDetailVC = characterDetailVC
            cell.url = characterVM.urls[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCell
    }
}
