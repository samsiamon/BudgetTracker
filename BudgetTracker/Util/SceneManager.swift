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

    func loginSilently() async {
        do {
            guard let idString = UserDefaults.standard.string(forKey: "userId") else {
                throw LoginError.couldNotLogin
            }
            guard let userId: UUID = UUID(uuidString: idString) else {
                throw LoginError.couldNotLogin
            }
            guard let userData: UserModel = try await userService.loginUserWithId(id: userId) else {
                throw LoginError.couldNotLogin
            }
            currentUser = userData
            scene = .loggedIn
        } catch {
            print("Could not login, please try again")
        }
    }

    func loginWithEmailAndPassword(userDTO: UserDTO) async {
        do {
            guard let user = try await userService.loginUserWithEmailAndPassword(email: userDTO.email) else {
                throw LoginError.couldNotLogin
            }
            if userDTO.password != user.password {
                throw LoginError.couldNotLogin
            }
            let defaults = UserDefaults.standard
            defaults.set(user.id.uuidString, forKey: "userId")
            currentUser = user
            scene = .loggedIn
        } catch {
            print("Could not login")
        }
    }

    func logout() async {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: "userId")
        scene = .loggedOut
    }

    func createAccount(user: UserDTO) async {
        do {
            guard let user = try await userService.createAccount(user: user) else {
                throw HTTPError.accountCreationError
            }
            let defaults = UserDefaults.standard
            defaults.set(user.id.uuidString, forKey: "userId")
            currentUser = user
            scene = .loggedIn
        } catch {
            print("Could not create account")
        }
    }
}

enum SceneView {
    case loggedIn, loggedOut, launch
}

enum LoginError: Error {
    case couldNotLogin
}
