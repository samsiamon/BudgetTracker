//
//  SceneManager.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/18/23.
//

import Foundation

@MainActor
class SceneManager: ObservableObject {
    @Published var currentUser: UserModel?
    @Published var scene: SceneView = .loggedOut
    private let userService = UserService()

    func loginSilently() async -> UserModel? {
        do {
            guard let user = currentUser else {
                throw LoginError.couldNotLogin
            }
            let responseUser = try await userService.loginUserWithId(id: user.id)
            if user != responseUser {
                throw LoginError.couldNotLogin
            }
            guard let userId: UUID = UUID(uuidString: UserDefaults.standard.string(forKey: "userId")!) else {
                throw LoginError.couldNotLogin
            }
            guard let userData: UserModel = try await userService.loginUserWithId(id: userId) else {
                throw LoginError.couldNotLogin
            }
            scene = .loggedIn
            return userData
        } catch {
            print("Could not login, please try again")
            return nil
        }
    }

    func loginWithEmailAndPassword(email: String, password: String) async -> UserModel? {
        do {
            guard let user = try await userService.loginUserWithEmailAndPassword(email: email) else {
                throw LoginError.couldNotLogin
            }
            if password != user.password {
                throw LoginError.couldNotLogin
            }
            let defaults = UserDefaults.standard
            defaults.set(user.id.uuidString, forKey: "userId")
            scene = .loggedIn
            return user
        } catch {
            print("Could not login")
            return nil
        }
    }

    func logout() async {
        currentUser = nil
        scene = .loggedOut
    }
}

enum SceneView {
    case loggedIn, loggedOut, launch
}

enum LoginError: Error {
    case couldNotLogin
}
