//
//  PrimaryButton.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

protocol PrimaryButtonViewDelegate: AnyObject {

    func primaryButtonTapped(_ button: PrimaryButton)

}

final class PrimaryButton: UIButton, XibLoadable {

    // MARK: - Public Properties

    weak var delegate: PrimaryButtonViewDelegate?

    // MARK: - Private Properties

    private var view: UIView?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        congifure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        congifure()
    }

    // MARK: - Public methods

    public func setTitle(_ title: String) {
        setTitle(title, for: .normal)
    }

    public func setBackgroundColor(_ color: UIColor) {
        view?.backgroundColor = color
    }

    public func setButtonTitleColor(_ color: UIColor) {
        setTitleColor(color, for: .normal)
    }

    // MARK: - Private methods

    private func congifure() {
        let view = PrimaryButton.loadFromXib()
        self.view = view
        setupView(view: view)
        view.isUserInteractionEnabled = false
        view.cropView()
        view.layer.masksToBounds = true
        addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        setTitle("Default Button Title", for: .normal)
    }

    @objc func buttonAction(_: UIButton!) {
        delegate?.primaryButtonTapped(self)
    }

}
