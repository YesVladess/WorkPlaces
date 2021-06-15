//
//  SearchViewController.swift
//  Workplaces
//
//  Created by YesVladess on 11.05.2021.
//

import UIKit

final class SearchViewController: UIViewController, CanShowSpinner {

    // MARK: - Public Properties

    var spinner: SpinnerView = SpinnerView(style: .large)

    // MARK: - Private Varibles

    private let searchService: SearchServiceProtocol
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModels: [UserProfile] = [] {
        didSet {
            isEmptyList = viewModels.isEmpty
        }
    }
    private var isEmptyList = false
    private var isSearchBarEmpty: Bool { return searchController.searchBar.text?.isEmpty ?? true }

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureSearchController()
        configureTableView()
    }

    init(
        searchService: SearchServiceProtocol = ServiceLayer.shared.searchService
    ) {
        self.searchService = searchService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - IBOutlet

    @IBOutlet private var searchTableView: UITableView!

    // MARK: - Configure

    private func configureNavigationBar() {
        title = "Поиск друзей"
    }

    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Имя или никнейм"
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    private func configureTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.backgroundColor = .white
        searchTableView.separatorStyle = .singleLine
        searchTableView.tableFooterView = UIView()
    }

    // MARK: - Private Methods

    private func filterContentForSearchText(_ searchString: String) {
        guard !searchString.isEmpty else { return }
        searchFriends(searchString)
        searchTableView.reloadData()
    }

    private func searchFriends(_ searchString: String) {
        searchService.searchFriends(searchString: searchString, completion: { [weak self] result in
            switch result {
            case .success(let friends):
                self?.viewModels = friends
            case .failure(_):
                self?.showError(searchString)
            }
        }
        )
    }

    private func showError(_ searchString: String) {
        let zeroScreen = ZeroScreenViewController(
            withModel: .getErrorModel(
                secondaryLabelTitle: "Что то пошло не так",
                actionButtonLabelTitle: "Обновить",
                action: { [weak self] in self?.searchFriends(searchString) }
            )
        )
        addFullScreen(child: zeroScreen)
    }

}

extension SearchViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }

}

extension SearchViewController: UITableViewDelegate {

}

// TODO: - В отдельный обьект?
extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellNib = UINib(nibName: "FriendCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: "FriendCell")

        let viewModel = viewModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell
        // Тут настройка ячейки
        cell?.update(withModel: viewModel)
        return cell ?? UITableViewCell()
    }

}
