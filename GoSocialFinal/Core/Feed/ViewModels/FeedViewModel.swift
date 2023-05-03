//
//  FeedViewModel.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/27/23.
//

import Foundation

class FeedViewModel: ObservableObject {
    
    @Published var thoughts = [Thought]()
    let service = ThoughtService()
    let userService = UserService()
    
    init() {
        fetchThoughts()
    }
    
    func fetchThoughts() {
        service.fetchThoughts { thoughts in
            self.thoughts = thoughts
            
            for i in 0 ..< thoughts.count {
                let uid = thoughts[i].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.thoughts[i].user = user
                }
            }
        }
    }
}
