//
//  Pixels.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/28/23.
//

import SwiftUI

struct Pixels: View {
    let size: CGFloat
    let color: Color
    
    var body: some View {
        Rectangle()
            .frame(width: size, height: size )
            .foregroundColor(color)
    }
}
