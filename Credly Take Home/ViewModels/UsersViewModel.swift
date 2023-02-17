//
//  UsersViewModel.swift
//  Credly Take Home
//
//  Created by Victor Germanis on 2/17/23.
//

import Foundation
import Alamofire

class UsersViewModel {
    
    static let cellReuseIdentifier = "userCell"

    private let userAPI: UsersAPIProtocol
    private var userData = [UserModel]()
    
    var userDataCount: Int {
        return userData.count
    }
    
    init(userAPI: UsersAPIProtocol = UsersAPI()) {
        self.userAPI = userAPI
    }
    
    func fetchUserData(completion: @escaping (String?) -> Void) {
        userAPI.fetchData { [weak self] result in
            self?.processResult(result, completion: completion)
        }
    }
    
    func cell(for tableView: UITableView, at index: Int) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersViewModel.cellReuseIdentifier) as? UserTableViewCell else {
            return UITableViewCell()
        }

        let user = userData(at: index)
        cell.email.text = user?.email
        cell.name.text = user?.name
        cell.phoneNumber.text = user?.phone
        return cell
    }
    
    // MARK: - private functions
    
    private func processResult(_ result: Result<[UserModel], Error>, completion: @escaping (String?) -> Void) {
        switch result {
        case .success(let users):
            userData = users
            completion(nil)
        case .failure(let error):
            completion(errorMessage(error))
        }
    }
    
    private func errorMessage(_ error: Error) -> String {
        if let error = error as? AFError {
            switch error {
            case .invalidURL(let url):
                return "Invalid URL: \(url) - \(error.localizedDescription)"
            default:
                return "Network issue occurred. Please try again."
            }
        } else if let error = error as? URLError {
            return "URLError occurred: \(error)"
        } else if let _ = error as? UsersAPI.UsersAPIError {
            return "No data returned in response"
        } else {
            return "Unknown error: \(error)"
        }
    }
    
    private func userData(at index: Int) -> UserModel? {
        guard userData.count > index else {
            return nil
        }
        return userData[index]
    }
}
