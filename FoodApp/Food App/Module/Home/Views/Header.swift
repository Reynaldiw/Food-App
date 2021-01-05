//
//  Header.swift
//  Food App
//
//  Created by Amin faruq on 17/12/20.
//

import SwiftUI
import Core
import Meal

struct Header: View {
    
    @State var showUpdate = false
    
    @EnvironmentObject var searchPresenter: SearchPresenter<MealModel, Interactor<String, [MealModel], SearchMealsRepository<GetMealsRemoteDataSource, MealsTransformer<MealTransformer<IngredientTransformer>>>>>

        
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.9843137255, green: 0.7529411765, blue: 0.1764705882, alpha: 1))
            VStack {
                HStack(){
                    Text("Meals Recipes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                        .padding(.bottom)
                    Spacer()
                }
                
                HStack(){
                    Text("Search recipes ..")
                        .foregroundColor(Color(#colorLiteral(red: 0.8901960784, green: 0.9137254902, blue: 0.9294117647, alpha: 1)))
                        .padding()
                    
                    Spacer()
                }
                .background(Color(#colorLiteral(red: 0.7607843137, green: 0.5607843137, blue: 0, alpha: 1)))
                .cornerRadius(12)
                .padding(.horizontal)
                .onTapGesture(perform: {
                    self.showUpdate.toggle()
                })
                .sheet(isPresented: $showUpdate, content: {
                    SearchView(presenter: searchPresenter)
                })
                
                
            }
        }
        .cornerRadius(24)
    }
    
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
            .previewDevice("iPhone 12")

    }
}
