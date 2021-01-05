//
//  CustomIcon.swift
//  Food App
//
//  Created by Amin faruq on 18/12/20.
//

import SwiftUI

struct CustomIcon: View {
    
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 28))
                .foregroundColor(.red)
            
            Text(title)
                .font(.caption)
                .padding(.top, 8)
                .foregroundColor(.red)
        }
    }
    
}
