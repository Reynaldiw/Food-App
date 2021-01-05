//
//  SearchView.swift
//  Food App
//
//  Created by Amin faruq on 19/12/20.
//

import SwiftUI
import Core
import Meal
import Lottie

struct SearchView: View {
    
    @ObservedObject var presenter: SearchPresenter<MealModel, Interactor<String, [MealModel], SearchMealsRepository<GetMealsRemoteDataSource, MealsTransformer<MealTransformer<IngredientTransformer>>>>>
    
    
    var body: some View {
        VStack{
            SearchBar(
                text: $presenter.keyword,
                onSearchButtonClicked: presenter.search
            )
            
            ZStack {
                if presenter.isLoading {
                    loadingIndicator
                } else if presenter.keyword.isEmpty {
                    emptyTitle
                } else if presenter.list.isEmpty {
                    emptyMeals
                } else if presenter.isError {
                    errorIndicator
                } else {
                    
                    NavigationView {
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(
                                self.presenter.list,
                                id: \.id
                            ) { meal in
                                ZStack {
                                    self.linkBuilder(for: meal) {
                                        SearchRow(meal: meal)
                                    }.buttonStyle(PlainButtonStyle())
                                    
                                }.padding(8)
                            }
                        }
                        .edgesIgnoringSafeArea(.all)
                        .navigationBarHidden(true)
                    }
                }
            }
            Spacer()
        }
        
    }
}

extension SearchView {
    var loadingIndicator: some View {
        VStack {
            LottieView(fileName: "loading")
                .frame(width: 50, height: 50)
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyTitle: some View {
        VStack {
            LottieView(fileName: "empty-folder")
                .frame(width: 200, height: 200)
            
            Text("Come on, find your favorite food!")
        }
    }
    var emptyMeals: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: "Data not found"
        ).offset(y: 80)
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

