//
//  ZeroScreenViewController.swift
//  workplaces
//
//  Created by YesVladess on 19.04.2021.
//

import UIKit

final class ZeroScreenViewController: UIViewController {

    // MARK: - Initializers

    init(withModel model: ZeroScreenViewModel) {
        self.viewModel = model
        super.init(nibName: "ZeroScreenViewController", bundle: Bundle(for: type(of: self)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Properties

    private var viewModel: ZeroScreenViewModel

    // MARK: - IBOutlet

    @IBOutlet private var errorImageView: UIImageView!
    @IBOutlet private var mainLabel: UILabel!
    @IBOutlet private var secondaryLabel: UILabel!
    @IBOutlet private var actionButton: UIButton!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView(withViewModel: self.viewModel)
    }

    // MARK: - IBAction

    @IBAction private func actionButtonTapped(_ sender: Any) {
    }

    // MARK: - Private Methods
    
    private func configureView(withViewModel viewModel: ZeroScreenViewModel) {
        errorImageView.image = viewModel.image
        mainLabel.attributedText = viewModel.mainLabelTitle?.addAttributes(font: .title, color: .black)
        secondaryLabel.attributedText =
            viewModel.secondaryLabelTitle?.addAttributes(font: .bodyLarge, color: .middleGrey)
        let actionButtonTitle = viewModel.actionButtonLabelTitle?.addAttributes(font: .bodyLarge, color: .orange)
        actionButton.setAttributedTitle(actionButtonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    @objc private func buttonAction() {
        let action = viewModel.action
        action()
    }

}
