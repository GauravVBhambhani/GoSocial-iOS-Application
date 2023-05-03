//
//  ThoughtFilterViewModel.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/26/23.
//

import Foundation

enum ThoughtFilterViewModel: Int, CaseIterable {
    case thoughts
//    case replies
    case likes
    
    var title: String {
        switch self {
            case .thoughts: return "Thoughts"
//            case .replies: return "Replies"
            case .likes: return "Likes"
        }
    }
}
