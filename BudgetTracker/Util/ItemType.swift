//
//  ItemType.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/16/23.
//

import Foundation

enum ItemType: Double, CaseIterable, Identifiable {
    case expense = -1
    case income = 1

    var name: String {
        switch (self) {
        case .expense:
            return "Expense"
        case .income:
            return "Income"
        }
    }

    var id: Self {
        return self
    }
}
