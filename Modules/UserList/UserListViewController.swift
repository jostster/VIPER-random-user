//
//  UserListViewController.swift
//  RandomUsers
//
//  Created by Brian Jost on 8/29/21.
//  
//

import UIKit

class UserListViewController: UIViewController, UserListViewable, StoryboardLoadable {
	@IBOutlet var tableView: UITableView!
	
    var presenter: UserListPresentable!
	var users: [UserListData] = []
	let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = UserListRouter.buildModule(self)

		setUpView()
        
        presenter.viewDidLoad()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		deselectCell()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		tableView.frame = view.bounds
	}
	
	func setUpView() {
		tableView.register(UINib(nibName: "UserListCell", bundle: nil), forCellReuseIdentifier: "UserListCell")
		
		refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
		refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
		tableView.refreshControl = refreshControl
	}
	
	@objc func refresh() {
		refreshControl.beginRefreshing()
		presenter.interactor.requestData()
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for:segue, sender:sender)
    }
    
    @IBAction func unwindToUserListViewController(_ segue:UIStoryboardSegue) {
    }
	
	func showData(_ users: [UserListData]) {
		self.users = users
		refreshControl.endRefreshing()
		tableView.reloadData()
	}
	
	func showNoData() {
		self.users = []
		refreshControl.endRefreshing()
		tableView.reloadData()
	}
	
	func deselectCell() {
		if let selectedRow = tableView.indexPathForSelectedRow {
			tableView.deselectRow(at: selectedRow, animated: true)
		}
	}
}

extension UserListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as? UserListCell else {
			return UITableViewCell()
		}
		
		let user = users[indexPath.row]
		
		cell.configure(user)
		
		return cell
	}
}

extension UserListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.didTapUserCellIndex(indexPath.row)
	}
}
