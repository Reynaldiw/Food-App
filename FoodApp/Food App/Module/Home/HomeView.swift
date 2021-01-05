//
//  HomeView.swift
//  Food App
//
//  Created by Amin faruq on 17/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Category
import Lottie

struct HomeView: View {
    
    @ObservedObject var presenter: GetListPresenter<Any, CategoryModel, Interactor<Any, [CategoryModel], GetCategoriesRepository<GetCategoriesLocaleDataSource, GetCategoriesRemoteDataSource, CategoryTransformer>>>
    
    var body: some View {
        VStack{
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else if presenter.list.isEmpty {
                emptyCategories
            } else {
                Header()
                    .edgesIgnoringSafeArea(.top)
                    .frame(width: 390, height: 100)
                    
                content
            }
        }.onAppear{
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: nil)
            }
        }
        
    }
}

extension HomeView {
    
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
    
    var emptyCategories: some View {
        CustomEmptyView(
            image: "assetNoFavorite",
            title: "The meal category is empty"
        ).offset(y: 80)
    }
    
    
    var content : some View{
      
        ScrollView(.vertical , showsIndicators : false){
          
            textHeader
                .padding(.top)
            
            VStack{
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 100) , spacing: 8)
                    
                ], spacing : 16) {
                    
                    ForEach( self.presenter.list,
                             id: \.id) { item in
                        
                        linkBuilder(for: item) {
                            CategoriesRow(category: item)
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        }
                       
                    }
                    
                }
                .padding(.vertical , 18)
                .padding(.horizontal)
                
            }
        }
    }
    
    var textHeader : some View {
        HStack {
            Text("Meal categories")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color.red)
                .padding(.horizontal)
            
            Spacer()
        }
    }
    
    func linkBuilder<Content: View>(
        for category: CategoryModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        
        NavigationLink(
            destination: HomeRouter().makeMealsView(for: category)
        ) { content() }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            HomeView()
//        }
//    }
//}


