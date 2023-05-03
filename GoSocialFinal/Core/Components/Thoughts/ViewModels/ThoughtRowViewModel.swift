//
//  ThoughtRowViewModel.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/27/23.
//

import Foundation

class ThoughtRowViewModel: ObservableObject {
    
    @Published var thought: Thought
    private let service = ThoughtService()

    init(thought: Thought) {
        self.thought = thought
        checkIfUserLikedThought()
    }
    
    func likeThought() {
        service.likeThought(thought) {
            self.thought.didLike = true
        }
    }
    
    func unlikeThought() {
        service.unlikeThought(thought) {
            self.thought.didLike = false
        }
    }
    
    func checkIfUserLikedThought() {
        service.checkIfUserLikedThought(thought) { didLike in
            if didLike {
                self.thought.didLike = true
            }
        }
    }
}
