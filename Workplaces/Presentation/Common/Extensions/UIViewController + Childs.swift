//
//  UIViewController + Childs.swift
//  Workplaces
//
//  Created by YesVladess on 26.05.2021.
//

import UIKit

extension UIViewController {

    func add(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func addFullScreen(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.view.frame = view.bounds
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    func get<T>(child: T) -> T? {
        return self.children.compactMap({ ($0 as? T) }).first
    }

    func transition(
        to child: UIViewController,
        fullScreen: Bool = false,
        completion: ((Bool) -> Void)? = nil
    ) {
        let duration = 0.4

        let current = children.last
        addChild(child)

        let newView = child.view!
        newView.translatesAutoresizingMaskIntoConstraints = true
        newView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if fullScreen { newView.frame = view.bounds }

        if let existing = current {
            existing.willMove(toParent: nil)

            transition(
                from: existing,
                to: child,
                duration: duration,
                options: [.transitionCrossDissolve],
                animations: { },
                completion: { done in
                    existing.removeFromParent()
                    child.didMove(toParent: self)
                    completion?(done)
                }
            )

        } else {
            view.addSubview(newView)

            UIView.animate(
                withDuration: duration,
                delay: 0,
                options: [.transitionCrossDissolve],
                animations: { },
                completion: { done in
                    child.didMove(toParent: self)
                    completion?(done)
                }
            )
        }
    }

}
