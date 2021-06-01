//
//  CharacterTableView.swift
//  Marvel
//
//  Created by Anna on 30/05/2021.
//

import UIKit

class CharacterTableView: UIView {
    @IBOutlet weak var charactersTableView: UITableView!
    
    private let nibNameCell = "CharacterTableViewCell"
    private let nibNameLoadCell = "LoadTableViewCell"
    
    private var isLoading = false
    
    var characterListVC = CharacterListViewController() {
        didSet {
            uploadData()
        }
    }
    var characterList = [CharacterViewModel]()
    var total = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerNib()
        setDelegates()
    }
    
    private func uploadData() {
        characterList = characterListVC.characterDataContainerVM.characterListVM
        total = characterListVC.characterDataContainerVM.total
    }
    
    private func registerNib() {
        let nibNames = [nibNameCell, nibNameLoadCell]
        nibNames.forEach { (name) in
            let nib = UINib(nibName: name, bundle: Bundle.main)
            charactersTableView.register(nib, forCellReuseIdentifier: name)
        }
    }
    
    private func setDelegates() {
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            isLoading = true
            getMoreCharacters()
        }
    }
    
    private func getMoreCharacters() {
        let first = characterList.count
        if Utils.isConnectedToNetwork() {
            characterListVC.characterDataContainerVM.getData(first: first) {
                self.uploadData()
                DispatchQueue.main.async {
                    self.charactersTableView.reloadData()
                    self.isLoading = false
                }
            } loadError: {
                Utils.showAlert(self.characterListVC, description: "Ha ocurrido algún error al cargar más personajes")
                self.isLoading = false
            }
        } else {
            Utils.showAlert(characterListVC, description: "No tienes conexión a internet")
            isLoading = false
        }
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension CharacterTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return total > characterList.count ? characterList.count+1 : characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        if index == characterList.count,
           let cell = tableView.dequeueReusableCell(withIdentifier: nibNameLoadCell, for: indexPath) as? LoadTableViewCell {
            return cell
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: nibNameCell, for: indexPath) as? CharacterTableViewCell {
            let character = characterList[index]
            cell.characterImageView.loadImage(stringURL: character.imageURLString)
            cell.nameLabel.text = character.name
            cell.descriptionLabel.text = character.description
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Utils.isConnectedToNetwork() {
            let characterDetailVC = CharacterDetailViewController()
            characterDetailVC.modalPresentationStyle = .fullScreen
            characterDetailVC.characterId = characterList[indexPath.row].characterId
            characterListVC.present(characterDetailVC, animated: true)
        } else {
            Utils.showAlert(characterListVC, description: "No tienes conexión a internet")
        }
    }
}
