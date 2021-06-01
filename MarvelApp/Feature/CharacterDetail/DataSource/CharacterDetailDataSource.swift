//
//  CharacterDetailDataSource.swift
//  MarvelApp
//
//  Created by Anna on 31/05/2021.
//

import Foundation
import Alamofire
import CryptoSwift

class CharacterDetailDataSource: NSObject {
    
    func getResponse(characterId: Int,
                     success succeed: (@escaping (CharacterModel) -> Void),
                     failure fail: (@escaping () -> Void)) {
        
        let url = "\(Constants.baseURL)/v1/public/characters/\(characterId)"
        
        let time = NSDate().timeIntervalSince1970.description
        let parameters: [String: Any] = [
            "apikey": Constants.publicKey,
            "ts": time,
            "hash": "\(time)\(Constants.privateKey)\(Constants.publicKey)".md5(),
            "offset": 0,
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
                
                if let dataWrapper = response.value,
                   dataWrapper.code == 200,
                   let dataContainer = dataWrapper.data,
                   let result = dataContainer.results,
                   let detail = result.first {
                    succeed(detail)
                    return
                }
                
                fail()
            }
    }
    
}
