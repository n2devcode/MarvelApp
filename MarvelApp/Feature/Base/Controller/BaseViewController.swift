//
//  BaseViewController.swift
//  MarvelApp
//
//  Created by Anna on 01/06/2021.
//

import UIKit

class BaseViewController: UIViewController, LoadViewProtocol, AddSubviewConstraintsProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func gotoBack() {
        self.dismiss(animated: true)
    }
    
    func loadData() {}
    func showLoadView() {}
    func showErrorView() {}
}
