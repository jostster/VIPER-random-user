//
//  UserDetailsContract.swift
//  RandomUsers
//
//  Created by Brian Jost on 8/30/21.
//  
//

import UIKit

/// Dumb view: UIViewController
protocol UserDetailsViewable: AnyObject {
    var presenter: UserDetailsPresentable! { get }
}

/// Handles user interaction
protocol UserDetailsPresentable: AnyObject {
    var view: UserDetailsViewable! { get }
    var interactor: UserDetailsInteractableInput! { get }
    var router: UserDetailsRoutable! { get }
    
    func viewDidLoad()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)

    func didTapEmailAddress()
	func displayError(_ error: String)
}

/// Business logic and handles data requests and delegate transfer
protocol UserDetailsInteractableInput: AnyObject {
    var output: UserDetailsInteractableOutput! { get }
}

/// Handles data response transfer
protocol UserDetailsInteractableOutput: AnyObject {
}

/// Handles navigation
protocol UserDetailsRoutable: AnyObject {
    var view: UserDetailsViewController! { get }
	var parentController: UserListViewController! { get }

	static func buildModule(_ viewController: UserDetailsViewController?, userDetails: UserListData) -> UIViewController
	
	func presentUserDetailsModule(userDetails: UserListData)
	func presentMailModule(with user: UserListData)
}
