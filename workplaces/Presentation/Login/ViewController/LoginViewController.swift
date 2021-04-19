//
//  LoginViewController.swift
//  workplaces
//
//  Created by YesVladess on 18.04.2021.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let child = ZeroScreenViewController()
        add(child)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.showLoader()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        sleep(2)
        view.removeLoader()
    }

}
