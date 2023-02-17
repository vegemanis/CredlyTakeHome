//
//  UsersAPIMock.swift
//  Credly Take HomeTests
//
//  Created by Victor Germanis on 2/17/23.
//

@testable import Credly_Take_Home

class UsersAPIMock: UsersAPIProtocol {
    
    var result: Result<[UserModel], Error> = .success([])
    
    func fetchData(completion: ((Result<[UserModel], Error>) -> Void)?) {
        completion?(result)
    }
}
