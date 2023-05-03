//
//  ProfileViewModel.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/27/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var thoughts = [Thought]()
    @Published var likedThoughts = [Thought]()
    
    private let service = ThoughtService()
    private let userService = UserService()
    
    let user: User
    
    init(user: User) {
        self.user = user
        self.fetchUserThoughts()
        self.fetchLikedThoughts()
    }
    
    var actionButtonTitle: String {
        return user.isCurrentUser ? "Edit Profile" : "Follow"
    }
    
    func thoughts(forFilter filter: ThoughtFilterViewModel) -> [Thought] {
        switch filter {
        case .thoughts:
            return thoughts
//        case .replies:
//            return thoughts
        case .likes:
            return likedThoughts
        }
    }
    
    func fetchUserThoughts() {
        guard let uid = user.id else {return}
        service.fetchThoughts(forUid: uid) { thoughts in
            self.thoughts = thoughts
            
            for i in 0 ..< thoughts.count {
                self.thoughts[i].user = self.user
            }
        }
    }
    
    func fetchLikedThoughts() {
        guard let uid = user.id else {return}
        service.fetchLikedThoughts(forUid: uid) { thoughts in
            self.likedThoughts = thoughts
            
            for i in 0 ..< thoughts.count {
                let uid = thoughts[i].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.likedThoughts[i].user = user
                }
            }
            
        }
    }
}
