//
//  MainView.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/17/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var budgetListManager = BudgetListManager()
    var body: some View {
        BudgetListView()
            .environmentObject(budgetListManager)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
