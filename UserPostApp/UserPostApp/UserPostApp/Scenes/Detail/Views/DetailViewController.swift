//
//  DetailViewController.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 9.04.2022.
//

import UIKit

class DetailViewController: UIViewController {

    var viewModel: DetailViewModel!
    var post: Post?
    
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var bodyLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Details"
        setupViewModel()
    }
    
    func setupViewModel() {
        viewModel = DetailViewModel(post: post!)
        setupViews()
    }
    
    private func setupViews() {
        // Getting data from API Post Model
        self.titleLbl.text = viewModel.post.title?.uppercased()
        self.bodyLbl.text = viewModel.post.body

    }
    
    // When clicking the Show Comments button, it opens the next page with using postId to match comments and posts
    @IBAction func readCommentsBtn(_ sender: UIButton) {

        if let postId = viewModel.getPostId() {
            let commentVC = CommentViewController()
            commentVC.postId = postId
            self.navigationController?.pushViewController(commentVC, animated: true)
        }
    }
    
}
