//
//  UsersAPI.swift
//  Credly Take Home
//
//  Created by Victor Germanis on 2/17/23.
//

import JSONParserSwift

struct UsersAPI: UsersAPIProtocol {
    private let urlForAPI = "https://jsonplaceholder.typicode.com/users"
    private let networkManager: NetworkManagerProtocol
    
    enum UsersAPIError: Error {
        case responseEmpty
    }
    
    init (networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchData(completion: ((Result<[UserModel], Error>) -> Void)?) {
        networkManager.request(urlForAPI: urlForAPI) { response in
            switch response.result {
            case .success(let data):
                completion?(self.parseResponse(data))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    private func parseResponse(_ data: Data?) -> Result<[UserModel], Error> {
        guard let data = data else {
            return .failure(UsersAPIError.responseEmpty)
        }
        do {
            let result: [UserModel] = try JSONParserSwift.parse(data: data)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
