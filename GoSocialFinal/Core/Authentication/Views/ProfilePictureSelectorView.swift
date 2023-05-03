//
//  ProfilePictureSelectionView.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/26/23.
//

import SwiftUI

struct ProfilePictureSelectorView: View {
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImageData: Data?
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            AuthHeaderView(title1: "Setup account", title2: "Add Profile Picture")
            
            Button {
                showImagePicker.toggle()
            } label: {
                if let imageData = profileImageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .padding(.top, 44)
                        .clipShape(Circle())
                } else {
                    Image("addDp")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(.systemBlue))
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .padding(.top, 44)
                }
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            
            if let selectedImage = selectedImage {
                Button {
                    print("Registered User Successfully")
                    viewModel.uploadDp(selectedImage)
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                }
            }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else {
            return
        }
        profileImageData = selectedImage.pngData()
    }
}


struct ProfilePictureSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePictureSelectorView()
    }
}
