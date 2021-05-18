//
//  ProfileTabViewController.swift
//  Workplaces
//
//  Created by YesVladess on 12.05.2021.
//

import UIKit

protocol ProfileTabViewControllerDelegate: AnyObject {
    func postsTapped()
    func likesTapped()
    func friendTapped()
}

class ProfileTabViewController: UIViewController {

    weak var delegate: ProfileTabViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }

    @IBOutlet private weak var segmentedControl: UISegmentedControl!

    @IBAction private func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            delegate?.postsTapped()
        case 1:
            delegate?.likesTapped()
        case 2:
            delegate?.friendTapped()
        default:
            break
        }
    }
}
