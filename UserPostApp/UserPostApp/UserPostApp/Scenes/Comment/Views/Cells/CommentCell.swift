//
//  CommentCell.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 10.04.2022.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet private weak var bodyLbl: UILabel!
    @IBOutlet private weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with comment: Comment) {
        bodyLbl.text = comment.body
        nameLbl.text = comment.name
    }
    
}
