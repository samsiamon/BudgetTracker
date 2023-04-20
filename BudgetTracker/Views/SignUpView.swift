//
//  SignUpView.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/20/23.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var sceneManager: SceneManager
    @State var user: UserDTO = UserDTO(email: "", password: "")
    @State var isDisabled = true
    @State var confirmPassword: String = ""

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
            HStack {
                Text("Confirm Password: ")
                    .bold()
                SecureField("Confirm Password", text: $confirmPassword)
                    .onChange(of: confirmPassword) { password in
                        isDisabled = user.password != password
                    }
            }
            if user.password != confirmPassword {
                Text("Passwords do not match")
                    .foregroundColor(.red)
            }
            Button("Create Account") {
                Task {
                    await sceneManager.createAccount(user: user)
                }
            }
            .disabled(isDisabled)
            .buttonStyle(.borderedProminent)
            .bold()
            .tint(AppColors.color2)
            .foregroundColor(AppColors.color4)
        }
        .padding(.horizontal)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
