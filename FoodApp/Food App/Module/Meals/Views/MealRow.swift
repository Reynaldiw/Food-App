//
//  MealRow.swift
//  Food App
//
//  Created by Amin faruq on 18/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Meal

struct MealRow: View {
    
    var meal: MealModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                self.imageMeal
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height,
                        alignment: .center
                    )
                self.blurView
                    .frame(
                        width: geometry.size.width,
                        height: 32
                    )
                self.titleMeal
            }
        }.cornerRadius(12)
    }
}

extension MealRow {
    var blurView: some View {
        BlurView()
    }
    
    var imageMeal: some View {
        WebImage(url: URL(string:meal.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
    }
    
    var titleMeal: some View {
        Text(meal.title)
            .font(.system(size: 14))
            .lineLimit(1)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8))
    }
}

//struct MealRow_Previews: PreviewProvider {
//    static var previews: some View {
//        var meal: MealModel
//
//        MealRow(meal: meal)
//    }
//}
