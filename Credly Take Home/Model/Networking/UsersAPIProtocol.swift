//
//  UsersAPIProtocol.swift
//  Credly Take Home
//
//  Created by Victor Germanis on 2/17/23.
//

import Foundation

protocol UsersAPIProtocol {
    func fetchData(completion: ((Result<[UserModel], Error>) -> Void)?)
}
