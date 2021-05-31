//
//  PrimaryButton.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

final class PrimaryButton: UIButton {

    // MARK: - Public Properties

    var onTap: (() -> Void)?

    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = .orange
                setTitleColor(.white, for: .normal)
            } else {
                backgroundColor = .lightGreyBlue
                setTitleColor(.middleGrey, for: .normal)
            }
        }
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0.0,
                    options: UIView.AnimationOptions.curveEaseIn,
                    animations: { self.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8) }
                )
            } else {
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0.3,
                    animations: { self.transform = CGAffineTransform.identity }
                )
            }
        }
    }

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

    // MARK: - Private methods

    private func congifure() {
        cropView()
        layer.masksToBounds = true
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        setTitle("Default Button Title", for: .normal)
    }

    // MARK: - Objc

    @objc func buttonAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard self?.onTap != nil else { return }
            self?.onTap!()
        }
    }

}
