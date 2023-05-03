//
//  AuthViewModel.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/26/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    
//    @Published var userSession: FirebaseAuth.User?
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var currentUser: User?
    
    private var tempUserSession: FirebaseAuth.User?
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        self.fetchUser()
    }
    
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                let message = error.localizedDescription
                let alert = UIAlertController(title: "Login Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
                return
            }
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            print("UPDATE: User logged in.")
        }
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        // Check if the fullname and username fields are not empty
        guard !fullname.trimmingCharacters(in: .whitespaces).isEmpty else {
            let message = "Fullname field is mandatory"
            let alert = UIAlertController(title: "Registration Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }
        
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty else {
            let message = "Username field is mandatory"
            let alert = UIAlertController(title: "Registration Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                let message = error.localizedDescription
                let alert = UIAlertController(title: "Registration Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
                return
            }
            
            guard let user = result?.user else { return }
            
            self.tempUserSession = user
            
            let data = ["email": email,
                        "username": username.lowercased(),
                        "fullname": fullname,
                        "uid": user.uid]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    self.didAuthenticateUser = true
                }
        }
    }

    
    func signOut() {
        //signs user out on local
        userSession = nil
        
        //signs user out from firebase session as well
        try? Auth.auth().signOut()
    }
    
    func uploadDp(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else {return}
        
        ImageUploader.uploadImage(image: image) { dpImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["dpImageUrl": dpImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else {return}
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
    
}

