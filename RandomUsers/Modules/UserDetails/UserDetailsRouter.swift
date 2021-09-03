//
//  UserDetailsRouter.swift
//  RandomUsers
//
//  Created by Brian Jost on 8/30/21.
//  
//

import UIKit
import MessageUI

class UserDetailsRouter: UserDetailsRoutable {	
	
    weak var view: UserDetailsViewController!
	weak var parentController: UserListViewController!

	static func buildModule(_ viewController: UserDetailsViewController? = nil, userDetails: UserListData) -> UIViewController {
        let viewController = viewController ?? UIStoryboard.loadViewController() as UserDetailsViewController
        let presenter = UserDetailsPresenter()
        let router = UserDetailsRouter()
        let interactor = UserDetailsInteractor()
		
        viewController.presenter =  presenter
		viewController.user = userDetails
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
		presenter.userDetails = userDetails
        
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
	
	func presentUserDetailsModule(userDetails: UserListData) {
		let detailsViewController = UserDetailsRouter.buildModule(nil, userDetails: userDetails)
		detailsViewController.modalPresentationStyle = .formSheet
		
		view.present(detailsViewController, animated: true, completion: nil)
	}
	
	func presentMailModule(with user: UserListData) {
		guard MFMailComposeViewController.canSendMail() else {
			view.presenter.displayError("Mail service is not supported on this device.")
			return
		}
		
		let mailController = MFMailComposeViewController()
		mailController.setToRecipients([user.email])
		mailController.mailComposeDelegate = view
		
		view.present(mailController, animated: true, completion: nil)
	}

}
