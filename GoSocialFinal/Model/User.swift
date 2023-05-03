//
//  User.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/27/23.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let dpImageUrl: String
    let email: String
    
    var isCurrentUser: Bool {return Auth.auth().currentUser?.uid == id}
}

