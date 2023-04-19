//
//  NavBar.swift
//  BudgetTracker
//
//  Created by Sam.Siamon on 4/18/23.
//

import SwiftUI

struct NavBar: View {
    @EnvironmentObject var sceneManager: SceneManager
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .frame(width: .infinity, height: 60)
                .foregroundColor(AppColors.color1)
            Button("Logout") {
                Task {
                    await sceneManager.logout()
                }
            }
            .foregroundColor(AppColors.color4)
            .bold()
            .tint(AppColors.color2)
            .buttonStyle(.borderedProminent)
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
            .previewLayout(.sizeThatFits)
    }
}
