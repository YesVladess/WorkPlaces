//
//  PrimaryButton.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import UIKit

protocol PrimaryButtonViewDelegate: class {
    func primaryButtonTapped(_ button: PrimaryButton)
}

@IBDesignable
class PrimaryButton: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var button: UIButton!

    let nibName = "PrimaryButton"
    let cornerRadius: CGFloat = 14.0
    weak var delegate: PrimaryButtonViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    public func setTitle(_ title: String) {
        button.setTitle(title, for: .normal)
    }

    @IBAction private func buttonTapped(_ sender: Any) {
        delegate?.primaryButtonTapped(self)
    }

    private func setup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
                self.addSubview(view)
        contentView = view

        button.layer.cornerRadius = cornerRadius
        button.setTitle("Primary Button Title", for: .normal)
    }

    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
