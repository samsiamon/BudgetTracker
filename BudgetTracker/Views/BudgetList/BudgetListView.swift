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
        VStack {
            Spacer()
            Picker(
                "/ " + budgetListManager.frequencyFilter.name,
                selection: $budgetListManager.frequencyFilter) {
                    ForEach(ItemFrequency.allCases) { freq in
                        Text("/ " + freq.name)
                    }
                }

            List {
                if budgetListManager.budgetList.isEmpty {
                    HStack {
                        Spacer()
                        Text("Add a new item!")
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                showAddItemView = true
                            }
                        Spacer()
                    }
                }
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
            
            Spacer()

            VStack {
                HStack {
                    Text("Total:")
                    Text("$" + String(format: "%.2f", budgetListManager.total))
                        .foregroundColor(budgetListManager.total < 0 ? .red : .green)
                    Text("/ " + budgetListManager.frequencyFilter.name)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .font(.title)
                .bold()
                Button("Add New Item") {
                    showAddItemView = true
                }
            }
            .frame(alignment: .bottom)
        }
        .popover(isPresented: $showAddItemView) {
            AddBudgetItemView {
                showAddItemView = false
            }
        }
        .padding(.top)
    }
}

struct BudgetListView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetListView()
            .environmentObject(BudgetListManager())
    }
}
