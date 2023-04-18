//
//  BudgetTrackerApp.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/16/23.
//

import SwiftUI

@main
struct BudgetTrackerApp: App {
    @StateObject var sceneManager = SceneManager()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(sceneManager)
        }
    }
}
