//
//  UploadThoughtViewModel.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/27/23.
//

import Foundation

class UploadThoughtViewModel: ObservableObject {
    @Published var didUploadThought = false
    
    let service = ThoughtService()
    
    func uploadThought(withCaption caption: String) {
        service.uploadThought(caption: caption) { success in
            if success {
                // dismiss screen
                self.didUploadThought = true
            } else {
                // show error message to user
            }
        }
    }
}
