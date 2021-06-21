//
//  CharacterDataContainerDataSource.swift
//  MarvelApp
//
//  Created by Anna on 31/05/2021.
//

import Foundation
import Alamofire
import CryptoSwift

class CharacterDataContainerDataSource: NSObject {
    
    func getResponse(first: Int,
                     success succeed: (@escaping (CharacterDataContainerModel) -> Void),
                     failure fail: (@escaping () -> Void)) {
        
        let url = "\(Constants.baseURL)/v1/public/characters"
        
        let time = NSDate().timeIntervalSince1970.description
        let parameters: [String: Any] = [
            "apikey": Constants.publicKey,
            "ts": time,
            "hash": "\(time)\(Constants.privateKey)\(Constants.publicKey)".md5(),
            "offset": first,
            "limit": 20,
            "orderBy": "-modified"
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.queryString,
                   headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: CharacterDataWrapperModel.self) { (response) in
                
                switch response.result {
                case .success(let value):
                    
                    if value.code == 200,
                       let dataContainer = value.data {
                        succeed(dataContainer)
                        return
                    }
                    
                    fail()
                case .failure(_):
                    fail()
                }
            }
    }
    
}
