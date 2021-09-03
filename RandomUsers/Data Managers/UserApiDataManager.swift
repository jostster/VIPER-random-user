//
//  UserApiDataManager.swift
//  RandomUsers
//
//  Created by Brian Jost on 8/29/21.
//

import Foundation
import Alamofire

protocol UserApiDataManagerProtocol {
	func getUsers(completion: @escaping (Result<[UserListData], Error>) -> Void)
}

class UserListResponse: Codable {
	let results: [UserListData]
}

class UserApiDataManager: UserApiDataManagerProtocol {
	func getUsers(completion: @escaping (Result<[UserListData], Error>) -> Void) {
		let parameters: Parameters = [
			"results": 40
		]
		
		AF.request(API.Endpoints.Users.fetch.url, parameters: parameters)
			.responseDecodable(of: UserListResponse.self) { response in
				switch (response.result) {
				case .success(let data):
					completion(.success(data.results))
				case .failure(let error):
					completion(.failure(error))
				}
			}
	}
}
