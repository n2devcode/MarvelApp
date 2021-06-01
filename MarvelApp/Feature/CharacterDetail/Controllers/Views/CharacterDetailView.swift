//
//  CharacterDetailView.swift
//  MarvelApp
//
//  Created by Anna on 01/06/2021.
//

import UIKit

class CharacterDetailView: UIView {
    @IBOutlet weak var characterDetailImageView: UIImageView!
    @IBOutlet weak var characterDetailDescriptionTitleLabel: UILabel!
    @IBOutlet weak var characterDetailDescriptionLabel: UILabel!
    @IBOutlet weak var characterDetailURLLabel: UILabel!
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
    var arrayURLs = [StructURLs]()
    
    private func loadDetail() {
        characterDetailImageView.loadImage(stringURL: characterVM.imageURLString)
        if characterVM.description.isEmpty || characterVM.description == Constants.noData {
            characterDetailDescriptionTitleLabel.text = ""
        }
        characterDetailDescriptionLabel.text = characterVM.description
        loadTableURLs()
    }
    
    private func loadTableURLs() {
        arrayURLs = characterVM.urls
        heightTableViewConstraint.constant = CGFloat(arrayURLs.count)*heightCell
        if !arrayURLs.isEmpty {
            registerNib()
            setDelegates()
        } else {
            characterDetailURLLabel.text = ""
        }
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
        return arrayURLs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: nibNameCell, for: indexPath) as? CharacterDetailURLTableViewCell {
            cell.characterDetailVC = characterDetailVC
            cell.url = arrayURLs[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCell
    }
}
