//
//  TabItem.swift
//  Food App
//
//  Created by Amin faruq on 19/12/20.
//

import SwiftUI

struct TabItem: View {
    
    var imageName: String
    var title: String
    var body: some View {
        VStack {
            Image(systemName: imageName)
            Text(title)
        }
    }
    
}
