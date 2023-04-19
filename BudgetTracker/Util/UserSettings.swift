//
//  UserSettings.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/18/23.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var store: Dictionary<String, AnyObject> = Dictionary()

    func set(key: String, object: AnyObject) {
        store[key] = object;
        UserDefaults.standard.set(store, forKey: "userDefaultData")
    }
}
