//
//  Atomic.swift
//  Workplaces
//
//  Created by YesVladess on 07.06.2021.
//

import Foundation

struct Atomic<Value> {
    private let queue = DispatchQueue(label: "AtomicValueQueue")
    private var wrappedValue: Value

    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }

    var value: Value {
        get { queue.sync { wrappedValue } }
        set { queue.sync { wrappedValue = newValue } }
    }

    mutating func mutate(_ block: (inout Value) -> Void) {
        queue.sync {
            block(&wrappedValue)
        }
    }
    
}
