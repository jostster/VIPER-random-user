//
//  UserListInteractor.swift
//  RandomUsers
//
//  Created by Brian Jost on 8/29/21.
//  
//

import Foundation

class UserListInteractor: UserListInteractableInput {
    weak var output: UserListInteractableOutput!
	
	let userApiDataManager: UserApiDataManager
	
	init(userApiDataManager: UserApiDataManager = UserApiDataManager()) {
		self.userApiDataManager = userApiDataManager
	}
    
	func requestData() {
		userApiDataManager.getUsers { results in
			switch results {
			case .success(let users):
				self.output.onDataFetched(.success(users))
			case .failure(let error):
				self.output.onDataFetched(.failure(error))
			}
		}
	}
}
