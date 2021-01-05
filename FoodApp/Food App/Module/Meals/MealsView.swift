//
//  MealsView.swift
//  Food App
//
//  Created by Amin faruq on 18/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Meal
import Category


struct MealsView: View {
    
    @ObservedObject var presenter: GetListPresenter<String, MealModel, Interactor<String, [MealModel], GetMealsRepository<GetMealsLocaleDataSource, GetMealsRemoteDataSource, MealsTransformer<MealTransformer<IngredientTransformer>>>>>
    
    var category: CategoryModel
    
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isLoading {
                errorIndicator
            } else {
                ScrollView(.vertical , showsIndicators: false) {
                    VStack {
                        imageCategory
                        spacer
                        content
                        spacer
                    }.padding()
                }
            }
        }.onAppear {
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: category.title)
            }
        }.navigationBarTitle(Text(category.title), displayMode: .large)
    }
}

extension MealsView {
    var spacer: some View {
        Spacer()
    }
    
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
    
    
    var imageCategory: some View {
        WebImage(url: URL(string: category.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 250.0, height: 250.0, alignment: .center)
    }
    
    var mealsHorizontal: some View {
        ScrollView(.horizontal , showsIndicators : false) {
            HStack {
                
                ForEach(self.presenter.list, id: \.id) { meal in
                    ZStack {
                        self.linkBuilder(for: meal) {
                            MealRow(meal: meal)
                                .frame(width: 150, height: 150)
                        }
                        
                    }
                }
            }
        }
    }
    
    var description: some View {
        Text(category.description)
            .font(.system(size: 15))
            .foregroundColor(.black)
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.headline)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !presenter.list.isEmpty {
                headerTitle("Meals from \(category.title)")
                    .padding(.bottom)
                    .foregroundColor(.red)
                mealsHorizontal
            }
            
            spacer
            headerTitle("Description")
                .padding([.top, .bottom])
                .foregroundColor(.black)
            description
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
