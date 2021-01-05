//
//  ContentView.swift
//  Food App
//
//  Created by Amin faruq on 17/12/20.
//

import SwiftUI
import Core
import Category
import Meal

struct ContentView: View {
    
    @EnvironmentObject var homePresenter: GetListPresenter<Any, CategoryModel, Interactor<Any, [CategoryModel], GetCategoriesRepository<GetCategoriesLocaleDataSource, GetCategoriesRemoteDataSource, CategoryTransformer>>>
    
    @EnvironmentObject var favoritePresenter: GetListPresenter<String, MealModel, Interactor<String, [MealModel], GetFavoriteMealsRepository<GetFavoriteMealsLocaleDataSource, MealsTransformer<MealTransformer<IngredientTransformer>>>>>
    
    
    var body: some View {
        TabView{
            NavigationView{
                HomeView(presenter: homePresenter)
            }.tabItem {
                TabItem(imageName: "house.fill", title: "Home")
            }
            
            NavigationView{
                FavoriteView(presenter: favoritePresenter)
            }.tabItem {
                TabItem(imageName: "heart", title: "Favorite")
            }
            
            NavigationView{
                AboutView()
            }.tabItem {
                TabItem(imageName: "person.circle.fill", title: "About")
            }
        }
        .accentColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
    }
}
