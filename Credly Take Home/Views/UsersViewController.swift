//
//  UsersViewController.swift
//  Credly Take Home
//
//  Created by Victor Germanis on 2/17/23.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    private let viewModel = UsersViewModel()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: UsersViewModel.cellReuseIdentifier)
        table.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadUserData), for: .valueChanged)
        reloadUserData() 
    }
    
    @objc private func reloadUserData() {
        viewModel.fetchUserData() { errorMessage in
            DispatchQueue.main.async { [weak self] in
                self?.refreshControl.endRefreshing()
                if let message = errorMessage {
                    self?.showAlert(message: message)
                } else {
                    self?.table.reloadData()
                }
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userDataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cell(for: tableView, at: indexPath.row)
    }
}

