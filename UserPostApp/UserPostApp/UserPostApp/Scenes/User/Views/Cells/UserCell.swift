//
//  UserCell.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 6.04.2022.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var usernameLbl: UILabel!
    @IBOutlet private weak var cityLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configure(with user: User) {
        nameLbl.text = user.name
        usernameLbl.text = "@" + (user.username?.lowercased() ?? "anonymous")
        cityLbl.text = "📍" + (user.address?.city ?? "anonymous")
    }
    
}
