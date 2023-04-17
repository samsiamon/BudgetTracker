//
//  ItemReoccurance.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/16/23.
//

import Foundation

// using values in terms of per month
enum ItemFrequency: Double, CaseIterable, Identifiable {
    case weekly = 0.02083
    case biweekly = 0.0417
    case monthly = 0.0833
    case bimonthly = 0.167
    case quarterly = 0.25
    case semianually = 0.5
    case anually = 1

    var name: String {
        switch (self) {
        case .weekly:
            return "Week"
        case .biweekly:
            return "2 Weeks"
        case .monthly:
            return "Month"
        case .bimonthly:
            return "2 Months"
        case .quarterly:
            return "3 Months"
        case .semianually:
            return "6 months"
        case .anually:
            return "Year"
        }
    }

    var id: Self {
        return self
    }
}
