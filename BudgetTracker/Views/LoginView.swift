//
//  LoginView.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/18/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var sceneManager: SceneManager

    @State var user: UserModel = UserModel(id: UUID(), email: "", password: "")

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Email: ")
                    .bold()
                TextField("Your Email Address", text: $user.email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            }
            HStack {
                Text("Password: ")
                    .bold()
                SecureField("Your Password", text: $user.password)

            }
            Button("Login") {
                Task {
                    sceneManager.currentUser = await sceneManager.loginWithEmailAndPassword(email: user.email, password: user.password)
                }
            }
            .buttonStyle(.borderedProminent)
            .bold()
            .tint(AppColors.color2)
            .foregroundColor(AppColors.color4)
            Button("Login as Guest") {
                sceneManager.scene = .loggedIn
            }
            .buttonStyle(.borderedProminent)
            .bold()
            .tint(AppColors.color2)
            .foregroundColor(AppColors.color4)
        }
        .textFieldStyle(.roundedBorder)
        .padding(.horizontal)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(user: UserModel(id: UUID(), email: "", password: ""))
            .environmentObject(SceneManager())
    }
}
