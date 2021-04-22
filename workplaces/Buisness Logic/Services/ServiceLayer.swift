//
//  ServiceLayer.swift
//  workplaces
//
//  Created by YesVladess on 20.04.2021.
//

import Foundation

class ServiceLayer {

    static var shared: ServiceLayer = {
        let instance = ServiceLayer()
        // ... настройка объекта
        return instance
    }()

    private init() {}
}
