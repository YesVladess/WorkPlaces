//
//  FeedViewController.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

final class FeedViewController: UIViewController, CanShowSpinner {

    // MARK: - Public Properties

    var spinner: SpinnerView = SpinnerView(style: .large)

    // MARK: - Private Properties

    private let feedService: FeedServiceProtocol

    // MARK: - Initializers

    init(
        feedService: FeedServiceProtocol = ServiceLayer.shared.feedService
    ) {
        self.feedService = feedService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Популярное"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getFeed()
    }

    // MARK: - Private Methods

    private func getFeed() {
        removeZeroScreenIfPresent()
        showSpinner()
        feedService.getFeed(completion: { [weak self] result in
            switch result {
            case .success(let result):
                if result.isEmpty { self?.showEmptyFeed() } else {
                    // self?.showFeed(posts: result)
                    self?.hideSpinner()
                }
            case.failure:
                self?.showFeedError()
            }
        })
    }

    private func showEmptyFeed() {
        let zeroScreen = ZeroScreenViewController(
            withModel: .getEmptyModel(
                secondaryLabelTitle: "Вам нужны друзья, чтобы лента стала живой",
                actionButtonLabelTitle: "Найти друзей",
                action: { [weak self] in self?.navigateToSearchScreen() }
            )
        )
        addFullScreen(child: zeroScreen)
        hideSpinner()
    }

    private func showFeedError() {
        let zeroScreen = ZeroScreenViewController(
            withModel: .getErrorModel(
                secondaryLabelTitle: "Что то пошло не так",
                actionButtonLabelTitle: "Обновить",
                action: { [weak self] in
                    self?.getFeed()
                }
            )
        )
        addFullScreen(child: zeroScreen)
    }

    //    private func showFeed(posts: [Post]) {
    //
    //    }

    // MARK: - Navigate

    private func navigateToSearchScreen() {
        let searchViewController = SearchViewController()
        navigationController?.pushViewController(searchViewController, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
