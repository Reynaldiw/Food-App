//
//  MealsRouter.swift
//  Food App
//
//  Created by Amin faruq on 19/12/20.
//

import SwiftUI
import Category
import Core
import Meal

class MealsRouter {
    
    func makeDetailView(for meal: MealModel) -> some View {
        let useCase: Interactor<
            String,
            MealModel,
            GetMealRepository<
                GetMealsLocaleDataSource,
                GetMealRemoteDataSource,
                MealTransformer<IngredientTransformer>>
        > = Injection.init().provideDetail()
        
        let favoriteUseCase: Interactor<
            String,
            MealModel,
            UpdateFavoriteMealRepository<
                GetFavoriteMealsLocaleDataSource,
                MealTransformer<IngredientTransformer>>
        > = Injection.init().provideUpdateFavorite()
        
        let presenter = MealPresenter(mealUseCase: useCase, favoriteUseCase: favoriteUseCase)
        
        return DetailView(presenter: presenter, meal: meal)
    }
}
