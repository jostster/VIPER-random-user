//
//  UserListPresenter.swift
//  RandomUsers
//
//  Created by Brian Jost on 8/29/21.
//  
//

import Foundation
import UIKit

class UserListPresenter: UserListPresentable {

    weak var view: UserListViewable!
    var router: UserListRoutable!
    var interactor: UserListInteractableInput!
    
	var data: [UserListData] = [] {
		didSet {
			if data.count > 0 {
				view.showData(data)
			} else {
				view.showNoData()
			}
		}
	}
     
    
    func viewDidLoad() {
		interactor.requestData()
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
	
	func didTapUserCellIndex(_ index: Int) {
		let user = data[index]
		router.presentUserDetails(user)
	}
}

extension UserListPresenter: UserListInteractableOutput {
	func onDataFetched(_ response: Result<[UserListData], Error>) {
		switch response {
		case .success(let users):
			self.data = users
		case .failure(let error):
			self.data = []
			router.displayError(error)
		}
	}
	
}
