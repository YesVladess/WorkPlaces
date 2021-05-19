//
//  FeedViewController.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

final class FeedViewController: UIViewController {

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
        getFeed()
    }

    // MARK: - Private Methods

    private func getFeed() {
        feedService.getFeed(completion: { [weak self] result in
            switch result {
            case .success(let result):
                if result.isEmpty { self?.showEmptyFeed() } else {
                    // self?.showFeed(posts: result)
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
        add(zeroScreen)
    }

    private func showFeedError() {
        let zeroScreen = ZeroScreenViewController(
            withModel: .getErrorModel(
                secondaryLabelTitle: "Что то пошло не так",
                actionButtonLabelTitle: "Обновить",
                action: { [weak self] in self?.getFeed() }
            )
        )
        add(zeroScreen)
    }

    // MARK: - Navigate

    private func navigateToSearchScreen() {
        let searchViewController = SearchViewController()
        navigationController?.pushViewController(searchViewController, animated: true)
    }

    //    private func showFeed(posts: [Post]) {
    //
    //    }

}
