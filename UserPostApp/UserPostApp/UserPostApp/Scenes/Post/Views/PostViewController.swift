//
//  PostViewController.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 7.04.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    // Set a userId to determine which posts going to be displayed
    var userId: Int = 0
    
    var postViewModel: PostViewModelProtocol! {
        didSet {
            postViewModel.delegate = self
        }
    }

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.navigationItem.title = "Posts"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postCell")
    }
    
    // MARK: ViewModel Call function
    private func setupViewModel() {
        let viewModel = PostViewModel(userId: userId, service: NetworkService())
        self.postViewModel = viewModel
        self.postViewModel.load()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewModel()
    }

}

// MARK: TableView
extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postViewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostCell
        cell.delegate = self
        if let post = postViewModel.post(index: indexPath.row) {
            cell.configure(with: post)
        }
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor(named: "selectColor")?.cgColor
        
        cell.layer.borderWidth = postViewModel.cellBorderWidth
        cell.layer.cornerRadius = postViewModel.cellCornerRadius
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return postViewModel.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return postViewModel.heightForHeader
    }
    
}

extension PostViewController: PostViewModelDelegate {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension PostViewController: PostCellDelegate {
    
    func didShowMoreButtonTapped(post: Post) {
        let detailVC = DetailViewController()
        detailVC.post = post
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}
