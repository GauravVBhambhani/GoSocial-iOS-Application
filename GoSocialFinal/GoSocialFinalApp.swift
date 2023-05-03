//
//  GoSocialFinalApp.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/26/23.
//

import SwiftUI
import Firebase

@main
struct GoSocialFinalApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
//                ProfilePictureSelectorView()
            }
            .environmentObject(viewModel)
        }
    }
}
