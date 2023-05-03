//
//  ThoughtService.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/27/23.
//

import Firebase

struct ThoughtService {
    
    func uploadThought(caption: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let data = ["uid": uid,
                    "caption": caption,
                    "likes": 0,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        
        Firestore.firestore().collection("thoughts").document()
            .setData(data) { error in
                
                if let error = error {
                    print("DEBUG: Failed to upload thought with error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
                
            }
    }
    
    
    func fetchThoughts(completion: @escaping([Thought]) -> Void) {
        Firestore.firestore().collection("thoughts")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                let thoughts = documents.compactMap({try? $0.data(as: Thought.self)})
                completion(thoughts)
            
            }
    }
    
    func fetchThoughts(forUid uid: String, completion: @escaping([Thought]) -> Void) {
        Firestore.firestore().collection("thoughts")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                let thoughts = documents.compactMap({try? $0.data(as: Thought.self)})
                completion(thoughts.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            
            }
    }
    
    
}

//MARK: likes

extension ThoughtService {
    func likeThought(_ thought: Thought, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let thoughtId = thought.id else {return}
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("thoughts").document(thoughtId)
            .updateData(["likes": thought.likes + 1]) { _ in
                userLikesRef.document(thoughtId).setData([:]) { _ in
                    completion()
                }
            }
        }
    
    func unlikeThought(_ thought: Thought, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let thoughtId = thought.id else {return}
        guard thought.likes > 0 else {return}
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("thoughts").document(thoughtId)
            .updateData(["likes": thought.likes - 1]) { _ in
                userLikesRef.document(thoughtId).delete { _ in
                    completion()
                    
                }
            }
    }
    
    func checkIfUserLikedThought(_ thought: Thought, completion: @escaping(Bool) -> Void ) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let thoughtId = thought.id else {return}
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(thoughtId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else {return}
                completion(snapshot.exists)
            }
    }
    
    func fetchLikedThoughts( forUid uid: String, completion: @escaping([Thought]) -> Void) {
        var thoughts = [Thought]()
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                documents.forEach{ doc in
                    let thoughtID = doc.documentID
                    
                    Firestore.firestore().collection("thoughts")
                        .document(thoughtID)
                        .getDocument { snapshot, _ in
                            guard let thought = try? snapshot?.data(as: Thought.self) else { return }
                            thoughts.append(thought)
                            completion(thoughts)
                        }
                }
            }
    }
}
