//
//  BudgetItem.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/16/23.
//

import Foundation

struct BudgetItem: Identifiable {
    let id: UUID = UUID()
    var name: String
    var itemType: ItemType
    var amount: Double
    var frequency: ItemFrequency
    var totalChangePerYear: Double {
        itemType.rawValue * amount / frequency.rawValue
    }

    init(name: String, itemType: ItemType, reoccurance: ItemFrequency, amount: Double) {
        self.name = name
        self.itemType = itemType
        self.frequency = reoccurance
        self.amount = amount
    }

    // default init
    init() {
        self.name = ""
        self.itemType = .income
        self.amount = 0
        self.frequency = .monthly
    }
}

