//
//  Protocols.swift
//  MarvelApp
//
//  Created by Anna on 31/05/2021.
//

import Foundation
import UIKit

protocol LoadViewProtocol {
    func loadView(_ nibName: String) -> UIView?
}
extension LoadViewProtocol {
    func loadView(_ nibName: String) -> UIView? {
        if nibName.isEmpty { return nil }
        let bundle = Bundle.main
        if let view = UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: nil, options: nil).first as? UIView {
            return view
        }
        return nil
    }
}

protocol AddSubviewConstraintsProtocol {
    func addSubview(view: UIView, subview: UIView)
}
extension AddSubviewConstraintsProtocol {
    func addSubview(view: UIView, subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        let trailingConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: view,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        )
        let leadingConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: view,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        )
        for view in view.subviews where view.tag != 999 {
            view.removeFromSuperview()
        }
        view.addSubview(subview)
        view.addConstraints([topConstraint, bottomConstraint, trailingConstraint, leadingConstraint])
    }
}
