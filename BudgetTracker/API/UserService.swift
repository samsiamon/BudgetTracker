//
//  UserService.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/18/23.
//

import Foundation

@MainActor
class UserService {
    let baseUrl: String = "http://localhost:8080"

    func loginUserWithId(id: UUID) async throws -> UserModel? {
        let url = URL(string: baseUrl + "/users/" + id.uuidString)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decodedResponse = try? JSONDecoder().decode(UserModel.self, from: data)
        return decodedResponse
    }


    func loginUserWithEmailAndPassword(email: String) async throws -> UserModel? {
        let url = URL(string: baseUrl + "/users/email/" + email)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decodedResponse = try? JSONDecoder().decode(UserModel.self, from: data)
        return decodedResponse
    }

    func createAccount(user: UserDTO) async throws -> UserModel? {
        let url = URL(string: baseUrl + "/users")
        var urlRequest = URLRequest(url: url!)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try JSONEncoder().encode(user)
        let (data, _response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = _response as? HTTPURLResponse else {
            throw HTTPError.accountCreationError
        }
        if response.statusCode != 201 {
            throw HTTPError.accountCreationError
        }
        let decodedResponse = try? JSONDecoder().decode(UserModel.self, from: data)
        return decodedResponse
    }
}

enum HTTPError: Error {
    case accountCreationError
}
