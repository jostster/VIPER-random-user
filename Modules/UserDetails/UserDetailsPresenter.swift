//
//  UserDetailsPresenter.swift
//  RandomUsers
//
//  Created by Brian Jost on 8/30/21.
//  
//

import Foundation
import UIKit

class UserDetailsPresenter: UserDetailsPresentable, UserDetailsInteractableOutput {
	
    weak var view: UserDetailsViewable!
    var router: UserDetailsRoutable!
    var interactor: UserDetailsInteractableInput!
	var userDetails: UserListData?
	
	func viewDidLoad() {
	}
	
	func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	}
	
	func didTapEmailAddress() {
		guard let userDetails = userDetails else { return }
		
		router.presentMailModule(with: userDetails)
	}
	
	func displayError(_ error: String) {
		let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
		
		alertController.addAction(okAction)
		
		router.view.present(alertController, animated: true, completion: nil)
	}

}
