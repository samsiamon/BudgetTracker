//
//  UpdateBudgetItemView.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/17/23.
//

import SwiftUI

struct UpdateBudgetItemView: View {
    @EnvironmentObject var budgetListManager: BudgetListManager
    @State var itemDetails: BudgetItem
    var dismiss: (() -> Void)?
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text("Item Name: ")
                    TextField("Name", text: $itemDetails.name, prompt: Text("ex. Job"))
                }
                HStack {
                    Text("Item Type: ")
                    Picker("Item Type", selection: $itemDetails.itemType) {
                        ForEach(ItemType.allCases) { type in
                            Text(type.name)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                HStack {
                    Text("Item Amount: ")
                    TextField("ex. 3000", value: $itemDetails.amount, format: .number, prompt: Text("ex. 3000"))
                        .keyboardType(.numbersAndPunctuation)
                }
                HStack {
                    Text("Item Frequency: ")
                    Picker("Frequency Picker", selection: $itemDetails.frequency) {
                        ForEach(ItemFrequency.allCases) { freq in
                            Text("/ " + freq.name)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .textFieldStyle(.roundedBorder)
            Spacer()
            Button("Submit") {
                budgetListManager.updateBudgetItem(item: itemDetails)
                dismiss?()
            }
            .frame(alignment: .bottom)
        }
        .padding()
    }
}

struct UpdateBudgetItemView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateBudgetItemView(itemDetails: BudgetItem(name: "Nuedesic", itemType: .expense, reoccurance: .anually, amount: 85000))
            .environmentObject(BudgetListManager())
    }
}
