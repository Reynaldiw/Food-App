//
//  DetailView.swift
//  Food App
//
//  Created by Amin faruq on 18/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Meal
import Core
import Category

struct DetailView: View {
    
    @State private var showingAlert = false
    
    
    @ObservedObject var presenter: MealPresenter<
        Interactor<String, MealModel, GetMealRepository<GetMealsLocaleDataSource, GetMealRemoteDataSource, MealTransformer<IngredientTransformer>>>,
        Interactor<String, MealModel, UpdateFavoriteMealRepository<GetFavoriteMealsLocaleDataSource, MealTransformer<IngredientTransformer>>>>
    
    var meal: MealModel
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imageMeal
                        menuButtonMeal
                        content
                    }.padding()
                }
            }
        }.onAppear {
            self.presenter.getMeal(request: meal.id)
        }.alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Oops!"),
                message: Text("Something wrong!"),
                dismissButton: .default(Text("OK"))
            )
        }.navigationBarTitle(
            Text(presenter.item?.title ?? ""),
            displayMode: .automatic
        )
    }
}

extension DetailView {
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
    
    var menuButtonMeal: some View {
        HStack(alignment: .center) {
            Spacer()
            CustomIcon(
                imageName: "link.circle",
                title: "Source"
            ).onTapGesture {
                self.openUrl(self.presenter.item?.source)
            }
            Spacer()
            CustomIcon(
                imageName: "video",
                title: "Video"
            ).onTapGesture {
                self.openUrl(self.presenter.item?.youtube)
            }
            Spacer()
            if presenter.item?.favorite == true {
                CustomIcon(
                    imageName: "heart.fill",
                    title: "Favorite"
                ).onTapGesture { self.presenter.updateFavoriteMeal(request: meal.id) }
            } else {
                CustomIcon(
                    imageName: "heart",
                    title: "Favorite"
                ).onTapGesture { self.presenter.updateFavoriteMeal(request: meal.id) }
            }
            Spacer()
        }.padding()
    }
    
    var imageMeal: some View {
        
        WebImage(url: URL(string: self.presenter.item?.image ?? ""))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width - 32, height: 250.0, alignment: .center)
            .cornerRadius(30)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            if presenter.item?.ingredients.isEmpty == false {
                Text("Ingredient")
                    .font(.headline)
                    .foregroundColor(.red)
                
                ForEach(self.presenter.item?.ingredients ?? [], id: \.id) { ingredient in
                    ZStack {
                        Text(ingredient.title)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                    }
                }
            }
            
            Divider()
                .padding(.vertical)
            
            Text("Instructions")
                .font(.headline)
                .foregroundColor(.red)
            
            Text(self.presenter.item?.instructions ?? "")
                .font(.system(size: 16))
                .foregroundColor(.black)
        }.padding(.top)
    }
}

extension DetailView {
    
    func openUrl(_ linkUrl: String?) {
        if let url = linkUrl, let link = URL(string: url) {
            UIApplication.shared.open(link)
        } else {
            showingAlert = true
        }
    }
    
}


//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
