//
//  SideMenuViewModel.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/26/23.
//

import Foundation


enum SideMenuViewModel: Int, CaseIterable {
    case profile
    case flappybird
//    case bookmarks
    case logout
    
    var description: String {
        switch self {
        case .profile: return "Profile"
        case .flappybird: return "Flappy Bird"
//        case .bookmarks: return "Bookmarks"
        case .logout: return "Logout"
        }
    }
    
    var imageName: String {
        switch self {
        case .profile: return "person"
        case .flappybird: return "bird"
//        case .bookmarks: return "bookmark"
        case .logout: return "arrow.left.square"
        }
    }
}
