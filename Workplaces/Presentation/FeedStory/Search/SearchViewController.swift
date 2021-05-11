//
//  SearchViewController.swift
//  Workplaces
//
//  Created by YesVladess on 11.05.2021.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Поиск друзей"
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTextField.delegate = self
    }

    // MARK: - IBOutlet

    @IBOutlet private weak var searchTableView: UITableView!
    @IBOutlet private weak var searchTextField: UITextField!

}

extension SearchViewController: UITextFieldDelegate {

}

extension SearchViewController: UITableViewDelegate {

}

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FriendCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        return cell
    }

}
