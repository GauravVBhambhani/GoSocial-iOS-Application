//
//  Thought.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/27/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Thought: Identifiable, Decodable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    let likes: Int
    
    var user: User?
    var didLike: Bool? = false
}
