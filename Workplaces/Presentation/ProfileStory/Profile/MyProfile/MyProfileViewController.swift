//
//  MyProfileViewController.swift
//  Workplaces
//
//  Created by YesVladess on 12.05.2021.
//

import UIKit

final class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

    // MARK: - IBOutlets

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var ageLabel: UILabel!

    // MARK: - IBAction

    @IBAction private func tapEditButton(_ sender: Any) {
    }

    // MARK: - Public Methods

    /**
     Setup profile with parameters

     - Parameter profile: UserProfile with all user info
     */
    func setupViewController(profile: UserProfile) {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        let birthDayString = formatter1.string(from: profile.birthDay)
        ageLabel.text = birthDayString
        nameLabel.text = "\(profile.firstName) \(profile.lastName)"
        // TODO: Добавить загрузку картинки
        imageView.image = #imageLiteral(resourceName: "Illustration_01")
    }

}
