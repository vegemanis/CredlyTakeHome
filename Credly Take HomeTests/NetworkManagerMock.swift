//
//  NetworkManagerMock.swift
//  Credly Take Home
//
//  Created by Victor Germanis on 2/17/23.
//

import Alamofire
@testable import Credly_Take_Home

class NetworkManagerMock: NetworkManagerProtocol {
    
    // default mock response
    var response = AFDataResponse<Data?>(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 5, result: .success(nil))
    
    func request(urlForAPI: String, completion: @escaping (AFDataResponse<Data?>) -> Void) {
        completion(response)
    }
}
