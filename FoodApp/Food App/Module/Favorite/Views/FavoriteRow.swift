//
//  FavoriteRow.swift
//  Food App
//
//  Created by Amin faruq on 19/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Meal
import Core

struct FavoriteRow: View {
    
    var meal: MealModel
    
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

extension FavoriteRow{
    var image: some View {
        WebImage(url: URL(string: meal.image))
            .resizable()
            .scaledToFill()
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            Text(meal.title)
                .lineLimit(1)
                .padding(.bottom, 8)
                .padding(.horizontal, 8)
                .foregroundColor(Color(#colorLiteral(red: 0.5764705882, green: 0.5647058824, blue: 0.5647058824, alpha: 1)))
        }
    }
}
