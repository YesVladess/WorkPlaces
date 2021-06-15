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

    // MARK: - Private Constants

    private let searchService: SearchServiceProtocol
    private let searchController = UISearchController(searchResultsController: nil)
    private let searchTaskDelayDuration = 0.75
    private let searchTableViewDataSource = SearchTableViewDataSource()

    // MARK: - Private Variables

    private var isSearchBarEmpty: Bool { return searchController.searchBar.text?.isEmpty ?? true }
    private var searchTask: DispatchWorkItem?

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
        searchTableView.dataSource = self.searchTableViewDataSource
        searchTableView.backgroundColor = .white
        searchTableView.separatorStyle = .none
        searchTableView.tableFooterView = UIView()
        searchTableView.reloadData()
    }

    // MARK: - Private Methods

    private func searchFriends(_ searchString: String) {
        removeZeroScreenIfPresent()
        guard !isSearchBarEmpty else {
            searchTableViewDataSource.viewModels = []
            searchTableView.reloadData()
            return
        }
        showSpinner()
        searchService.searchFriends(searchString: searchString, completion: { [weak self] result in
            switch result {
            case .success(let friends):
                self?.searchTableViewDataSource.viewModels = friends
                self?.hideSpinner()
                self?.searchTableView.reloadData()
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
        hideSpinner()
    }

}

extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar

        self.searchTask?.cancel()
        let task = DispatchWorkItem { [weak self] in
            self?.searchFriends(searchBar.text!)
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + searchTaskDelayDuration, execute: task)
    }

}
