//
//  UserListRouter.swift
//  RandomUsers
//
//  Created by Brian Jost on 8/29/21.
//  
//

import UIKit

class UserListRouter: UserListRoutable {
    weak var view: UserListViewController!

    static func buildModule(_ viewController: UserListViewController? = nil) -> UIViewController {
        let viewController = viewController ?? UIStoryboard.loadViewController() as UserListViewController
        let presenter = UserListPresenter()
        let router = UserListRouter()
        let interactor = UserListInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
	
	func presentUserListModule() {
		let nextViewController = UserListRouter.buildModule()
		view.navigationController?.pushViewController(nextViewController, animated: true)
	}
	
	func presentUserDetails(_ user: UserListData) {
		let detailsView = UserDetailsRouter.buildModule(userDetails: user)
		detailsView.modalPresentationStyle = .formSheet
		view.present(detailsView, animated: true, completion: nil)
	}

	func displayError(_ error: Error) {
		let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
		
		alertController.addAction(okAction)
		
		view.present(alertController, animated: true, completion: nil)
	}
}
