//
//  ZeroScreenViewModel.swift
//  workplaces
//
//  Created by YesVladess on 19.04.2021.
//

import UIKit

struct ZeroScreenViewModel {

    var image: UIImage?
    var mainLabelTitle: NSAttributedString?
    var secondaryLabelTitle: NSAttributedString?
    var actionButtonLabelTitle: NSAttributedString?
    var action: () -> Void

    static func getErrorModel(
        secondaryLabelTitle: String,
        actionButtonLabelTitle: String,
        action: @escaping () -> Void
    ) -> ZeroScreenViewModel {
        ZeroScreenViewModel(
            image: Images.errorImage,
            mainLabelTitle: "Ups".localized.addAttributes(font: .title, color: .black),
            secondaryLabelTitle: secondaryLabelTitle.addAttributes(font: .bodyLarge, color: .middleGrey),
            actionButtonLabelTitle: actionButtonLabelTitle.addAttributes(font: .bodyLarge, color: .orange),
            action: action
        )
    }

    static func getEmptyModel(
        secondaryLabelTitle: String,
        actionButtonLabelTitle: String,
        action: @escaping () -> Void
    ) -> ZeroScreenViewModel {
        ZeroScreenViewModel(
            image: Images.emptyImage,
            mainLabelTitle: "Emptyness".localized.addAttributes(font: .title, color: .black),
            secondaryLabelTitle: secondaryLabelTitle.addAttributes(font: .bodyLarge, color: .middleGrey),
            actionButtonLabelTitle: actionButtonLabelTitle.addAttributes(font: .bodyLarge, color: .orange),
            action: action
        )
    }

}
