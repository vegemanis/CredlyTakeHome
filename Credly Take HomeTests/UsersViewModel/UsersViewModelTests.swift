//
//  UsersViewModelTests.swift
//  Credly Take HomeTests
//
//  Created by Victor Germanis on 2/17/23.
//

import XCTest
import Alamofire
@testable import Credly_Take_Home

final class UsersViewModelTests: XCTestCase {
    
    func testSuccess() throws {
        let mock = UsersAPIMock()
        mock.result = .success([UserModel(dictionary: ["id" : 1])])
        let viewModel = UsersViewModel(userAPI: mock)
        let exp = expectation(description: "waiting on fetch result")
        viewModel.fetchUserData() { errorMessage in
            exp.fulfill()
            XCTAssertNil(errorMessage)
            XCTAssertEqual(viewModel.userDataCount, 1)
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testFailureInvalidURL() throws {
        let mock = UsersAPIMock()
        mock.result = .failure(AFError.invalidURL(url: try "invalidURL".asURL()))
        let viewModel = UsersViewModel(userAPI: mock)
        let exp = expectation(description: "waiting on fetch result")
        viewModel.fetchUserData() { errorMessage in
            exp.fulfill()
            XCTAssertNotNil(errorMessage)
            XCTAssertEqual(errorMessage, "Invalid URL: invalidURL - URL is not valid: invalidURL")
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testFailureURLError() throws {
        let mock = UsersAPIMock()
        mock.result = .failure(URLError(.appTransportSecurityRequiresSecureConnection))
        let viewModel = UsersViewModel(userAPI: mock)
        let exp = expectation(description: "waiting on fetch result")
        viewModel.fetchUserData() { errorMessage in
            exp.fulfill()
            XCTAssertNotNil(errorMessage)
            XCTAssertEqual(errorMessage, "URLError occurred: URLError(_nsError: Error Domain=NSURLErrorDomain Code=-1022 \"(null)\")")
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testFailureResponseEmpty() throws {
        let mock = UsersAPIMock()
        mock.result = .failure(UsersAPI.UsersAPIError.responseEmpty)
        let viewModel = UsersViewModel(userAPI: mock)
        let exp = expectation(description: "waiting on fetch result")
        viewModel.fetchUserData() { errorMessage in
            exp.fulfill()
            XCTAssertNotNil(errorMessage)
            XCTAssertEqual(errorMessage, "No data returned in response")
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testFailureOther() throws {
        let mock = UsersAPIMock()
        mock.result = .failure(NSError(domain: "unknown error", code: -100))
        let viewModel = UsersViewModel(userAPI: mock)
        let exp = expectation(description: "waiting on fetch result")
        viewModel.fetchUserData() { errorMessage in
            exp.fulfill()
            XCTAssertNotNil(errorMessage)
            XCTAssertEqual(errorMessage, "Unknown error: Error Domain=unknown error Code=-100 \"(null)\"")
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testCellCreationNoData() throws {
        let mock = UsersAPIMock()
        let viewModel = UsersViewModel(userAPI: mock)
        let cell = viewModel.cell(for: UITableView(), at: 0)
        XCTAssertNotNil(cell)
    }
    
    
    func testCellCreationInvlidIndex() throws {
        let mock = UsersAPIMock()
        let viewModel = UsersViewModel(userAPI: mock)
        let table = UITableView()
        table.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: UsersViewModel.cellReuseIdentifier)

        let cell = viewModel.cell(for: table, at: 10)
        XCTAssertNotNil(cell)
    }
    
    func testCellCreation() throws {
        let mock = UsersAPIMock()
        mock.result = .success([UserModel(dictionary: ["id" : 1, "name": "Victor", "email":"victor_g@gmail.com", "phone": "(999)734-0777"])])
        let viewModel = UsersViewModel(userAPI: mock)
        let exp = expectation(description: "waiting on fetch result")
        viewModel.fetchUserData() { errorMessage in
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
        
        let table = UITableView()
        table.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: UsersViewModel.cellReuseIdentifier)
        
        let cell = viewModel.cell(for: table, at: 0) as? UserTableViewCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.name.text, "Victor")
        XCTAssertEqual(cell?.phoneNumber.text, "(999)734-0777")
        XCTAssertEqual(cell?.email.text, "victor_g@gmail.com")
    }
}
