//
//  ZeroScreenViewModel.swift
//  workplaces
//
//  Created by YesVladess on 19.04.2021.
//

import UIKit

struct ZeroScreenViewModel {

    var image: UIImage?
    var mainLabelTitle: String?
    var secondaryLabelTitle: String?
    var actionButtonLabelTitle: String?
    var action: () -> Void

    static func getErrorModel(
        secondaryLabelTitle: String,
        actionButtonLabelTitle: String,
        action: @escaping () -> Void
    ) -> ZeroScreenViewModel {
        ZeroScreenViewModel(
            image: Images.errorImage,
            mainLabelTitle: "Ups".localized,
            secondaryLabelTitle: secondaryLabelTitle,
            actionButtonLabelTitle: actionButtonLabelTitle,
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
            mainLabelTitle: "Emptyness".localized,
            secondaryLabelTitle: secondaryLabelTitle,
            actionButtonLabelTitle: actionButtonLabelTitle,
            action: action
        )
    }

}
