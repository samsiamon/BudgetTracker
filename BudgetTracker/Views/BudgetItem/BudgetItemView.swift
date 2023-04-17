//
//  BudgetItemView.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/16/23.
//

import SwiftUI

struct BudgetItemView: View {
    @EnvironmentObject var budgetListManager: BudgetListManager
    @State var budgetItem: BudgetItem

    var body: some View {
        ZStack (alignment: .center) {
            Rectangle()
            HStack {
                VStack {
                    Text(budgetItem.name)
                        .font(.title)
                        .bold()
                }
                VStack {
                    Text("$" + String(format: "%.2f", budgetItem.totalChangePerYear * budgetListManager.frequencyFilter.rawValue))
                        .foregroundColor(budgetItem.itemType == .expense ? .red : .green)
                        .font(.title2)
                    .bold()
                    Text("/ " + budgetListManager.frequencyFilter.name)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: 103)
        .foregroundColor(.white)
    }
}

struct BudgetItemView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetItemView(
            budgetItem:
                        BudgetItem(name: "name", itemType: .income, reoccurance: .monthly, amount: 3000)
        )
            .previewLayout(.sizeThatFits)
            .environmentObject(BudgetListManager())
    }
}
