//
//  UserListCell.swift
//  RandomUsers
//
//  Created by Brian Jost on 8/29/21.
//

import UIKit

class UserListCell: UITableViewCell {
	@IBOutlet var firstName: UILabel!
	
	func configure(_ user: UserListData) {
		firstName.text = user.name.first
	}
}
