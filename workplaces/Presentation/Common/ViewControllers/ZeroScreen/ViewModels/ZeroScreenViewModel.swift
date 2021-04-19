//
//  ZeroScreenViewModel.swift
//  workplaces
//
//  Created by YesVladess on 19.04.2021.
//

import UIKit

class ZeroScreenViewModel {

    var errorImage: UIImage?
    var mainLabelTitle: NSAttributedString?
    var secondaryScreenTitle: NSAttributedString?
    var actionButtonLabelTitle: NSAttributedString?

    init(errorImageName: String,
         mainLabelTitle: String,
         secondaryScreenTitle: String,
         actionButtonLabelTitle: String) {
        self.errorImage = UIImage(named: errorImageName)
        self.mainLabelTitle = mainLabelTitle.addAttributes(font: .title, color: .black)
        self.secondaryScreenTitle = secondaryScreenTitle.addAttributes(font: .bodyLarge, color: .middleGrey)
        self.actionButtonLabelTitle = actionButtonLabelTitle.addAttributes(font: .bodyLarge, color: .orange)
    }

}
