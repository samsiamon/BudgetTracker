//
//  BudgetListView.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/16/23.
//

import SwiftUI

struct BudgetListView: View {

    @EnvironmentObject var budgetListManager: BudgetListManager
    @State var selectedItem: BudgetItem?
    @State var popover: BudgetListPopovers = .add
    @State var showPopover = false

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
                .tint(AppColors.color3)

            List {
                if budgetListManager.budgetList.isEmpty {
                    HStack {
                        Spacer()
                        Text("Add a new item!")
                            .fontWeight(.heavy)
                            .foregroundColor(AppColors.color3)
                            .onTapGesture {
                                popover = .add
                                showPopover = true
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
                            Button() {
                                selectedItem = item
                                popover = .edit
                                showPopover = true
                            } label: {
                                Label("Edit", systemImage: "pencil.line")
                            }
                        }
                }
            }
            .background(AppColors.color1)
            .scrollContentBackground(.hidden)
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
                    popover = .add
                    showPopover = true
                }
            }
            .frame(alignment: .bottom)
        }
        .popover(isPresented: $showPopover) {
            switch (popover) {
            case .add:
                AddBudgetItemView {
                    showPopover = false
                }
            case .edit:
                UpdateBudgetItemView(itemDetails: selectedItem!) {
                    showPopover = false
                    selectedItem = nil
                }
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

enum BudgetListPopovers {
    case add, edit
}
