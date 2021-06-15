//
//  WorkplacesNavigationController.swift
//  Workplaces
//
//  Created by YesVladess on 15.06.2021.
//

import UIKit

class WorkplacesNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barStyle = .default
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .middleGrey
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes =
            [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont(name: "IBMPlexSans", size: 16)!
            ]
    }

}
