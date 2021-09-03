//
//  UserDetailsViewController.swift
//  RandomUsers
//
//  Created by Brian Jost on 8/30/21.
//  
//

import UIKit
import Alamofire
import AlamofireImage
import MessageUI

class UserDetailsViewController: UIViewController, UserDetailsViewable, StoryboardLoadable {
	
	@IBOutlet var firstName: UILabel!
	@IBOutlet var lastName: UILabel!
	@IBOutlet var email: UILabel!
	@IBOutlet var avatar: UIImageView!
	
    var presenter: UserDetailsPresentable!
	var user: UserListData?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		presentationController?.delegate = self
		showUserInfo()
        
        presenter.viewDidLoad()
    }
		
	override func viewWillAppear(_ animated: Bool) {
		setUpView()
	}
	
	func setUpView() {
		view.roundCorners(corners: [.topLeft, .topRight], radius: 15)
		avatar.roundCorners(corners: [.allCorners], radius: avatar.frame.width / 2)
		
		let height = 200.0
		
		let bounds = view.superview?.bounds ?? view.bounds
		
		let startY = bounds.height - CGFloat(height)
		
		view.frame = CGRect(x: 0, y: startY, width: bounds.width, height: CGFloat(height))
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for:segue, sender:sender)
    }
    
    @IBAction func unwindToUserDetailsViewController(_ segue:UIStoryboardSegue) {
    }
	
	@IBAction func didTapEmailAddress() {
		presenter.didTapEmailAddress()
	}
    
    //    MARK: - StoryboardLoadable
    static func storyboardName() -> String {
        return "UserDetails"
    }
    
	func showUserInfo() {
		guard let user = user else { return }
		avatar.af.setImage(withURL: user.picture.thumbnail)
		firstName.text = user.name.first
		lastName.text = user.name.last
		email.text = user.email
	}
}

extension UserDetailsViewController: MFMailComposeViewControllerDelegate {
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		
		if result == .failed {
			let error = error?.localizedDescription ?? "Unknown email error"
			presenter.displayError(error)
		}
		dismiss(animated: true, completion: nil)
	}
}

extension UserDetailsViewController: UIAdaptivePresentationControllerDelegate {
	
	func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
		beginAppearanceTransition(false, animated: true)
		presentationController.presentingViewController.beginAppearanceTransition(true, animated: true)
		endAppearanceTransition()
		presentationController.presentingViewController.endAppearanceTransition()
	}
}
