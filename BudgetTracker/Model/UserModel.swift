//
//  UserModel.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/18/23.
//

import Foundation
struct UserModel: Identifiable, Codable, Equatable {
    var id: UUID
    var email: String
    var password: String
}
