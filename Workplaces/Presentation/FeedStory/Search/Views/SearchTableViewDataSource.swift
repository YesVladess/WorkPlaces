//
//  SearchTableViewDatasource.swift
//  Workplaces
//
//  Created by YesVladess on 15.06.2021.
//

import UIKit

final class SearchTableViewDataSource: NSObject, UITableViewDataSource {

    // MARK: - Private Constants

    private let profileService: ProfileServiceProtocol

    // MARK: - Initializers

    init(
        profileService: ProfileServiceProtocol = ServiceLayer.shared.profileService
    ) {
        self.profileService = profileService
    }
    
    // MARK: - Public Properties

    var viewModels: [UserProfile] = [] {
        didSet {
            isEmptyList = viewModels.isEmpty
        }
    }
    var isEmptyList = true

    // MARK: - Public Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isEmptyList ? 1 : viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !isEmptyList else {
            let cellNib = UINib(nibName: "EmptyFriendListTableViewCell", bundle: Bundle.main)
            tableView.register(cellNib, forCellReuseIdentifier: "EmptyFriendListTableViewCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyFriendListTableViewCell", for: indexPath)
            return cell
        }
        let cellNib = UINib(nibName: "FriendCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: "FriendCell")

        let viewModel = viewModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell
        cell?.delegate = self
        cell?.update(withModel: viewModel)
        return cell ?? UITableViewCell()
    }
    
}

extension SearchTableViewDataSource: FriendCellDelegate {

    func addFriend(withID userID: String) {
        profileService.addFriend(userID: userID, completion: { _ in
        }
        )
    }

}
