//
//  UserListContract.swift
//  RandomUsers
//
//  Created by Brian Jost on 8/29/21.
//  
//

import UIKit

/// Dumb view: UIViewController
protocol UserListViewable: AnyObject {
    var presenter: UserListPresentable! { get }
    
	func showData(_ users: [UserListData])
	func showNoData()

}

/// Handles user interaction
protocol UserListPresentable: AnyObject {
    var view: UserListViewable! { get }
    var interactor: UserListInteractableInput! { get }
    var router: UserListRoutable! { get }
    	
	func viewDidLoad()
	func prepare(for segue: UIStoryboardSegue, sender: Any?)

	func didTapUserCellIndex(_ index: Int)
}

/// Business logic and handles data requests and delegate transfer
protocol UserListInteractableInput: AnyObject {
    var output: UserListInteractableOutput! { get }
    
    func requestData()
}

/// Handles data response transfer
protocol UserListInteractableOutput: AnyObject {
    
	func onDataFetched(_ response: Result<[UserListData], Error>)
}

/// Handles navigation
protocol UserListRoutable: AnyObject {
    var view: UserListViewController! { get }

    static func buildModule(_ viewController: UserListViewController?) -> UIViewController
    
	func presentUserListModule()
	func presentUserDetails(_ user: UserListData)
	
	func displayError(_ error: Error)
}
