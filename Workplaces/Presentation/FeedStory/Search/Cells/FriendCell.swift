//
//  FriendCell.swift
//  Workplaces
//
//  Created by YesVladess on 11.05.2021.
//

import Kingfisher
import UIKit

protocol FriendCellDelegate: AnyObject {
    func addFriend(withID id: String)
}

final class FriendCell: UITableViewCell {

    // MARK: - Public Properties

    weak var delegate: FriendCellDelegate?

    // MARK: - Private Properties

    private var id: String?

    // MARK: - IBOutlets

    @IBOutlet private var nameAndSurnameLabel: UILabel!
    @IBOutlet private var nickNameLabel: UILabel!
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var plusButtonImageView: UIButton!

    // MARK: - IBActions

    @IBAction private func pressAddFriendButton(_ sender: Any) {
        guard let id = self.id else { return }
        delegate?.addFriend(withID: id)
    }

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        plusButtonImageView.tintColor = .middleGrey
        avatarImageView.image = Images.avatarPlaceHolder
        avatarImageView.cropView()
    }

    // MARK: - Public Methods

    func update(withModel model: UserProfile) {
        nameAndSurnameLabel.text = model.firstName + " " + model.lastName
        if let nickname = model.nickname {
            nickNameLabel.text = "@" + nickname
        }
        if let url = model.avatarUrl {
            avatarImageView.kf.setImage(with: url, placeholder: Images.avatarPlaceHolder)
        }
        self.id = model.id
    }

}
