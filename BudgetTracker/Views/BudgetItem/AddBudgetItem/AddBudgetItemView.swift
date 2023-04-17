//
//  AddBudgetItemView.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/16/23.
//

import SwiftUI

struct AddBudgetItemView: View {
    @EnvironmentObject var budgetListManager: BudgetListManager
    @State var itemDetails: BudgetItem = BudgetItem()
    var dismiss: (() -> Void)?
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text("Item Name: ")
                    TextField("ex. Job", text: $itemDetails.name)
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
                budgetListManager.addBudgetItem(item: itemDetails)
                dismiss?()
            }
            .frame(alignment: .bottom)
        }
        .padding()
    }
}

struct AddBudgetItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetItemView()
            .environmentObject(BudgetListManager())
    }
}
