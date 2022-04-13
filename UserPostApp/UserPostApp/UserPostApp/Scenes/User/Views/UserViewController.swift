//
//  HomePageViewController.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 6.04.2022.
//

import UIKit

class UserViewController: UIViewController {

    var userViewModel: UserViewModelProtocol! {
        didSet {
            userViewModel.delegate = self
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Setting the title and the button color of UINavigationBar
        self.navigationItem.title = "Users"
        self.navigationController?.navigationBar.tintColor = UIColor.red
        
        setupTableView()
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "userCell")
    }
    
    // Setup UserViewModel to use in UserViewController
    private func setupViewModel() {
        
        let viewModel = UserViewModel(service: NetworkService())
        self.userViewModel = viewModel
        self.userViewModel.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewModel()
    }

}

// MARK: TableView
extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userViewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserCell
        if let user = userViewModel.user(index: indexPath.row) {
            cell.configure(with: user)
        }
        
        // Cell Border Design
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor(named: "selectColor")?.cgColor
        cell.layer.borderWidth = userViewModel.cellBorderWidth
        cell.layer.cornerRadius = userViewModel.cellCornerRadius
        
        // Setting selected cell color from Assets
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(named: "selectColor")
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Using userId to get posts belong to selected user
        if let userId = userViewModel.getUserId(index: indexPath.row) {
            let postVC = PostViewController()
            postVC.userId = userId
            self.navigationController?.pushViewController(postVC, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return userViewModel.cellHeight
    }
    
}

extension UserViewController: UserViewModelDelegate {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
