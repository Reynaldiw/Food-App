//
//  CustomEmptyView.swift
//  Food App
//
//  Created by Amin faruq on 18/12/20.
//

import SwiftUI

struct CustomEmptyView: View {
  var image: String
  var title: String
  
  var body: some View {
    VStack {
      Image(image)
        .resizable()
        .renderingMode(.original)
        .scaledToFit()
        .frame(width: 250)
      
      Text(title)
        .font(.system(.body, design: .rounded))
    }
  }
}

struct CustomEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        CustomEmptyView(image: "", title: "")
            .previewDevice("iPhone 12")

    }
}
