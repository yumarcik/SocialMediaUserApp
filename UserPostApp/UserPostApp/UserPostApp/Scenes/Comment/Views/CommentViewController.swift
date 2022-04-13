//
//  CommentViewController.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 10.04.2022.
//

import UIKit

class CommentViewController: UIViewController {

    var postId: Int = 0
    var commentViewModel: CommentViewModelProtocol! {
        didSet {
            commentViewModel.delegate = self
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Comments"
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "commentCell")
    }
    
    private func setupViewModel() {
        let viewModel = CommentViewModel(postId: postId, service: NetworkService())
        self.commentViewModel = viewModel
        self.commentViewModel.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewModel()
    }

}

extension CommentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentViewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentCell
        if let comment = commentViewModel.comment(index: indexPath.row) {
            cell.configure(with: comment)
        }
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor(named: "selectColor")?.cgColor
        
        cell.layer.borderWidth = commentViewModel.cellBorderWidth
        cell.layer.cornerRadius = commentViewModel.cellCornerRadius

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return commentViewModel.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return commentViewModel.heightForHeader
    }
    
}

extension CommentViewController: CommentViewModelDelegate {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
