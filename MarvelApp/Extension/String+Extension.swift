//
//  String+Extension.swift
//  MarvelApp
//
//  Created by Anna on 31/05/2021.
//

import Foundation

extension String {
    
    func secureURL() -> String {
        let notSecure = "http://"
        let secure = "https://"
        if self.hasPrefix(notSecure), let range = self.range(of: notSecure) {
            var url = self
            url.removeSubrange(range)
            return "\(secure)\(url)"
        } else {
            return self
        }
    }
    
}
