//
//  ZeroScreenViewController.swift
//  workplaces
//
//  Created by YesVladess on 19.04.2021.
//

import UIKit

class ZeroScreenViewController: UIViewController {

    // MARK: - Public Properties
    var viewModel: ZeroScreenViewModel?

    // MARK: - IBOutlet
    @IBOutlet private weak var errorImageView: UIImageView!
    @IBOutlet private weak var mainLabel: UILabel!
    @IBOutlet private weak var secondaryLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!

    // MARK: - UIViewController(*)
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: - IBAction
    @IBAction private func actionButtonTapped(_ sender: Any) {
    }

    // MARK: - Private Methods
    func configureView() {
        // TODO: Пока не понял, где настраивать модель, настрою тут:
        let viewModel = ZeroScreenViewModel(
            errorImageName: "Illustration_01",
            mainLabelTitle: "Ups".localized,
            secondaryScreenTitle: "Something went wrong".localized,
            actionButtonLabelTitle: "Update".localized)
        self.viewModel = viewModel

        errorImageView.image = viewModel.errorImage
        mainLabel.attributedText = viewModel.mainLabelTitle
        secondaryLabel.attributedText = viewModel.secondaryScreenTitle
        actionButton.setTitle(viewModel.actionButtonLabelTitle?.string, for: .normal)
    }

}
