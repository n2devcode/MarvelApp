//
//  Utils.swift
//  MarvelApp
//
//  Created by Anna on 31/05/2021.
//

import Foundation
import SystemConfiguration
import UIKit

class Utils {
    
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return isReachable && !needsConnection
    }
    
    static func showAlert(_ viewController: UIViewController, description: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: description, message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Aceptar", style: .cancel, handler: nil)
            alert.addAction(cancel)
            viewController.present(alert, animated: true)
        }
    }
    
}
