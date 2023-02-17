//
//  UsersAPITests.swift
//  Credly Take HomeTests
//
//  Created by Victor Germanis on 2/17/23.
//

import XCTest
import Alamofire
@testable import Credly_Take_Home

final class UsersAPITests: XCTestCase {
    
    private func generateNetworkMock(result: Result<Data?, AFError>) -> AFDataResponse<Data?> {
        return AFDataResponse<Data?>(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 5, result: result)
    }

    func testSuccess() throws {
        let mock = NetworkManagerMock()

        mock.response = generateNetworkMock(result: .success(UsersAPIMockData.successClean))
        let usersAPI = UsersAPI(networkManager: mock)
        let exp = expectation(description: "waiting on fetch result")
        usersAPI.fetchData { result in
            exp.fulfill()
            switch result {
            case .failure( _):
                XCTFail("Expected success response")
            case .success(let users):
                XCTAssertEqual(users.count, 1)
                XCTAssertEqual(users.first?.id, 1)
                XCTAssertEqual(users.first?.name, "Leanne Graham")
            }
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testSuccessMissingName() throws {
        let mock = NetworkManagerMock()

        mock.response = generateNetworkMock(result: .success(UsersAPIMockData.successMissingName))
        let usersAPI = UsersAPI(networkManager: mock)
        let exp = expectation(description: "waiting on fetch result")
        usersAPI.fetchData { result in
            exp.fulfill()
            switch result {
            case .failure( _):
                XCTFail("Expected success response")
            case .success(let users):
                XCTAssertEqual(users.count, 1)
                XCTAssertEqual(users.first?.id, 1)
                XCTAssertNil(users.first?.name)
            }
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testSuccessNoUsers() throws {
        let mock = NetworkManagerMock()

        mock.response = generateNetworkMock(result: .success(UsersAPIMockData.successEmpty))
        let usersAPI = UsersAPI(networkManager: mock)
        let exp = expectation(description: "waiting on fetch result")
        usersAPI.fetchData { result in
            exp.fulfill()
            switch result {
            case .failure( _):
                XCTFail("Expected success response")
            case .success(let users):
                XCTAssertEqual(users.count, 0)
            }
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testFailureNoData() throws {
        let mock = NetworkManagerMock()

        mock.response = generateNetworkMock(result: .success(UsersAPIMockData.failEmpty))
        let usersAPI = UsersAPI(networkManager: mock)
        let exp = expectation(description: "waiting on fetch result")
        usersAPI.fetchData { result in
            exp.fulfill()
            switch result {
            case .success( _):
                XCTFail("Expected failure response")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
            }
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testFailureNilData() throws {
        let mock = NetworkManagerMock()

        mock.response = generateNetworkMock(result: .success(nil))
        let usersAPI = UsersAPI(networkManager: mock)
        let exp = expectation(description: "waiting on fetch result")
        usersAPI.fetchData { result in
            exp.fulfill()
            switch result {
            case .success( _):
                XCTFail("Expected failure response")
            case .failure(let error):
                XCTAssertTrue(error is UsersAPI.UsersAPIError)
            }
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testFailureInvalidJSON() throws {
        let mock = NetworkManagerMock()

        mock.response = generateNetworkMock(result: .success(UsersAPIMockData.failInvalidJSON))
        let usersAPI = UsersAPI(networkManager: mock)
        let exp = expectation(description: "waiting on fetch result")
        usersAPI.fetchData { result in
            exp.fulfill()
            switch result {
            case .success( _):
                XCTFail("Expected failure response")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
            }
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testFailureCancelled() throws {
        let mock = NetworkManagerMock()

        mock.response = generateNetworkMock(result: .failure(.explicitlyCancelled))
        let usersAPI = UsersAPI(networkManager: mock)
        let exp = expectation(description: "waiting on fetch result")
        usersAPI.fetchData { result in
            exp.fulfill()
            switch result {
            case .success( _):
                XCTFail("Expected failure response")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Request explicitly cancelled.")
            }
        }
        wait(for: [exp], timeout: 5)
    }
}
