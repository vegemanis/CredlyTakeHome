//
//  NetworkManager.swift
//  Credly Take Home
//
//  Created by Victor Germanis on 2/17/23.
//

import Alamofire

class NetworkManager: NetworkManagerProtocol {
    func request(urlForAPI: String, completion: @escaping (AFDataResponse<Data?>) -> Void) {
        AF.request(urlForAPI).response { response in
            completion(response)
        }
    }
}
