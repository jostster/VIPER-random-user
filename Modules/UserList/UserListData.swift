//
//  UserListData.swift
//  RandomUsers
//
//  Created by Brian Jost on 8/29/21.
//  
//

import Foundation

struct UserListData: Codable {
	let name: UserListName
	let email: String
	let picture: UserListPicture
}

struct UserListName: Codable {
	let first: String
	let last: String
}

struct UserListPicture: Codable {
	let thumbnail: URL
}
