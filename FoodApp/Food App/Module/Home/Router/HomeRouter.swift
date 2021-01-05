//
//  HomeRouter.swift
//  Food App
//
//  Created by Amin faruq on 19/12/20.
//

import SwiftUI
import Category
import Core
import Meal

class HomeRouter {
    func makeMealsView(for category: CategoryModel) -> some View {
        
        let useCase: Interactor<
            String,
            [MealModel],
            GetMealsRepository<
                GetMealsLocaleDataSource,
                GetMealsRemoteDataSource,
                MealsTransformer<MealTransformer<IngredientTransformer>>>
        > = Injection.init().provideMeals()
        
        let presenter = GetListPresenter(useCase: useCase)
        
        return MealsView(presenter: presenter, category: category)
    }
}
