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
    
    private let nibNameCell = "LoadTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
}

