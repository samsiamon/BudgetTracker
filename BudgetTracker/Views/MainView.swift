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
        ZStack {
            Rectangle()
                .frame(width: .infinity, height: .infinity)
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(AppColors.color1)
            VStack {
                switch(sceneManager.scene) {
                case .loggedIn:
                    BudgetListView()
                        .environmentObject(budgetListManager)
                case .loggedOut:
                    LoginView()
                        .task {
                            await sceneManager.loginSilently()
                        }
                case .launch:
                    EmptyView()
                }
                if (sceneManager.scene == .loggedIn) {
                    NavBar()
                        .frame(alignment: .bottom)
                }
            }
            .foregroundColor(AppColors.color3)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(SceneManager())
    }
}
