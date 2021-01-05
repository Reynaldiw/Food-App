//
//  HomeRow.swift
//  Food App
//
//  Created by Amin faruq on 17/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Category

struct CategoriesRow: View {
    
    var category: CategoryModel

    var body: some View {
        ZStack {
            VStack(alignment: .center){
                image
                content
            }
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 5)
        }
    }
}

extension CategoriesRow{
    var image: some View {
        WebImage(url: URL(string: category.image))
            .resizable()
            .scaledToFill()
            .padding(.top , 8)
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            Text(category.title)
                .lineLimit(1)
                .padding(.bottom, 8)
                .padding(.horizontal, 8)
                .foregroundColor(Color(#colorLiteral(red: 0.5764705882, green: 0.5647058824, blue: 0.5647058824, alpha: 1)))
        }
    }
}
