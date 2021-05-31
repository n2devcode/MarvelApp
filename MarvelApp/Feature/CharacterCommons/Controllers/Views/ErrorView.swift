//
//  ErrorView.swift
//  Marvel
//
//  Created by Anna on 30/05/2021.
//

import UIKit

class ErrorView: UIView {
    
    var characterListVC = CharacterListViewController()

    @IBAction func clickRetry(_ sender: Any) {
        characterListVC.loadData()
    }
    
}
