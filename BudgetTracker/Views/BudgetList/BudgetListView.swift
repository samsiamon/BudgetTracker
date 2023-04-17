//
//  BudgetListView.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/16/23.
//

import SwiftUI

struct BudgetListView: View {

    @EnvironmentObject var budgetListManager: BudgetListManager
    @State var showAddItemView = false

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                    Picker(
                        "/ " + budgetListManager.frequencyFilter.name,
                        selection: $budgetListManager.frequencyFilter) {
                            ForEach(ItemFrequency.allCases) { freq in
                                Text("/ " + freq.name)
                            }
                        }
                }
                .frame(maxWidth: .infinity, maxHeight:100)
                List {

                    ForEach(budgetListManager.budgetList) { item in
                        BudgetItemView(budgetItem: item)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    budgetListManager.removeBudgetItem(id: item.id)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }

                }
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                    VStack {
                        HStack {
                            Text("Total:")
                            Text("$" + String(format: "%.2f", budgetListManager.total))
                                .foregroundColor(budgetListManager.total < 0 ? .red : .green)
                        }
                        .font(.title)
                        .bold()
                        Button("Add New Item") {
                            showAddItemView = true
                        }
                        .popover(isPresented: $showAddItemView) {
                            AddBudgetItemView {
                                showAddItemView = false
                            }
                        }
                    }
                }
                .frame(alignment: .bottom)
                .frame(maxWidth: .infinity, maxHeight:100)
            }
            .padding(.top)
        }
        .frame(height: .infinity, alignment: .center)
    }
}

struct BudgetListView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetListView()
            .environmentObject(BudgetListManager())
    }
}
