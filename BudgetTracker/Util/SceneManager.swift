//
//  SceneManager.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/18/23.
//

import Foundation

class SceneManager: ObservableObject {
    var scene: SceneView = .loggedOut

    func loginSilently() {
        scene = .loggedIn
    }
}

enum SceneView {
    case loggedIn, loggedOut, launch
}
