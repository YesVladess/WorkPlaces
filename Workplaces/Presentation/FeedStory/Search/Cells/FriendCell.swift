//
//  FriendCell.swift
//  Workplaces
//
//  Created by YesVladess on 11.05.2021.
//

import UIKit

class FriendCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private var nameAndSurnameLabel: UILabel!
    @IBOutlet private var nickNameLabel: UILabel!

    func update(withModel model: UserProfile) {
        nameAndSurnameLabel.text = model.firstName + " " + model.lastName
        if let nickname = model.nickname {
            nickNameLabel.text = "@" + nickname
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
