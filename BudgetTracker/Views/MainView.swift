//
//  MainView.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/17/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var budgetListManager = BudgetListManager()
    @EnvironmentObject var sceneManager: SceneManager
    var body: some View {
        switch(sceneManager.scene) {
        case .loggedIn:
            BudgetListView()
                .environmentObject(budgetListManager)
        case .loggedOut:
            LoginView()
                .onAppear {
                    sceneManager.loginSilently()
                }
        case .launch:
            EmptyView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(SceneManager())
    }
}
