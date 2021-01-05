//
//  FavoriteView.swift
//  Food App
//
//  Created by Amin faruq on 18/12/20.
//

import SwiftUI
import Core
import Meal
import Lottie

struct FavoriteView: View {
    
    @ObservedObject var presenter: GetListPresenter<String, MealModel, Interactor<String, [MealModel], GetFavoriteMealsRepository<GetFavoriteMealsLocaleDataSource, MealsTransformer<MealTransformer<IngredientTransformer>>>>>
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else if presenter.list.count == 0 {
                emptyFavorites
            } else {
                content
            }
        }.onAppear {
            self.presenter.getList(request: nil)
        }.navigationBarTitle(
            Text("Favorite Meals")
        )
        
    }
    
    
    
}

extension FavoriteView{
    
    var loadingIndicator: some View {
        VStack {
            LottieView(fileName: "loading")
                .frame(width: 60, height: 60)
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyFavorites: some View {
        VStack {
            LottieView(fileName: "empty-box")
                .frame(width: 200, height: 200)
            
            Text("Your favorite is empty!")
            
        }
            
    }
    
    var content: some View {
        VStack {
            ScrollView(.vertical , showsIndicators : false){
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 140))
                    
                ], spacing : 62) {
                    
                    ForEach( self.presenter.list,
                             id: \.id) { item in
                        
                        self.linkBuilder(for: item) {
                            FavoriteRow(meal: item)
                                .frame(width: 150, height: 140)
                        }
                        
                    }
                    
                }
                .padding(.top , 40)
                .padding(.vertical , 20)
                .padding(.horizontal)
            }
        }
    }
    
    func linkBuilder<Content: View>(
        for meal: MealModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        
        NavigationLink(
            destination: MealsRouter().makeDetailView(for: meal)
        ) { content() }
    }
}

