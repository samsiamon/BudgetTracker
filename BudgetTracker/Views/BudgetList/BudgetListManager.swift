//
//  BudgetListManager.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/16/23.
//

import Foundation

class BudgetListManager: ObservableObject {
    @Published var budgetList: [BudgetItem]
    @Published var frequencyFilter: ItemFrequency = .monthly
    var total: Double {
        var total: Double = 0
        for item in budgetList {
            total += item.totalChangePerYear
        }
        return total * frequencyFilter.rawValue
    }

    init(budgetList: [BudgetItem] = []) {
        self.budgetList = budgetList
    }

    func addBudgetItem(item: BudgetItem) {
        budgetList.append(item)
    }

    func removeBudgetItem(id: UUID) {
        if let index = budgetList.firstIndex(where: { item in
            return item.id == id
        }) {
            budgetList.remove(at: index)
        } else {
            print("could not find item with id: " + id.uuidString)
        }
    }

    func updateBudgetItem(item: BudgetItem) {
        guard let index = budgetList.firstIndex(where: { listItem in
            return listItem.id == item.id
        }) else {
            print("could not find item with id: " + item.id.uuidString)
            return
        }
        budgetList[index] = item
    }
}
