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

final class PrimaryButton: UIButton {

    // MARK: - Public Properties

    weak var delegate: PrimaryButtonViewDelegate?

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

    func setPrimaryButtonEnabled(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
        if isEnabled {
            setBackgroundColor(.orange)
            setButtonTitleColor(.white)
        } else {
            setBackgroundColor(.lightGreyBlue)
            setButtonTitleColor(.middleGrey)
        }
    }

    // MARK: - Private methods

    private func congifure() {
        cropView()
        layer.masksToBounds = true
        addTarget(self, action: #selector(buttonAction(_:)), for: .touchDown)
        addTarget(self, action: #selector(releaseButton(_:)), for: .touchUpInside)
        setTitle("Default Button Title", for: .normal)
    }

    private func setBackgroundColor(_ color: UIColor) {
        backgroundColor = color
    }

    private func setButtonTitleColor(_ color: UIColor) {
        setTitleColor(color, for: .normal)
    }

    // MARK: - Objc

    @objc func buttonAction(_: UIButton!) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: UIView.AnimationOptions.curveEaseIn,
            animations: { self.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8) },
            completion: nil
        )
    }

    @objc func releaseButton(_: UIButton!) {
        UIView.animate(
            withDuration: 0.3,
            animations: { self.transform = CGAffineTransform.identity },
            completion: { [weak self] _ in
            self?.delegate?.primaryButtonTapped(self!)
            }
        )
    }

}
