//
//  NetworkManagerProtocol.swift
//  Credly Take Home
//
//  Created by Victor Germanis on 2/17/23.
//

import Alamofire

protocol NetworkManagerProtocol {
    func request(urlForAPI: String, completion: @escaping (AFDataResponse<Data?>) -> Void)
}


