//
//  PostCell.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 7.04.2022.
//

import UIKit

// Using Delegate to send postId to the next screen Detail
protocol PostCellDelegate {
    
    func didShowMoreButtonTapped(post: Post)
}

class PostCell: UITableViewCell {

    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var showMoreBtn: UIButton!
    
    private var post: Post?
    var delegate: PostCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with post: Post) {
        
        titleLbl.text = post.title?.uppercased()
        self.post = post
    }
    
    @IBAction private func showMoreBtn(_ sender: UIButton) {
        
        if let post = post {
            self.delegate?.didShowMoreButtonTapped(post: post)
        }
    }
    
}
