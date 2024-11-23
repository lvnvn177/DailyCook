//
//  SearchView.swift
//  DailyCook
//
//  Created by 이영호 on 11/23/24.
//

import SwiftUI


struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @State var search: String = ""
    @State var showSearchResult = false
    @State private var showSavedRecipes = false
    
    var RecipeOptions = ["반찬","국","후식"]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true, content: {
                VStack(alignment: .leading) {
                    ZStack {
                        HStack {
                            Button(action: {
                                showSavedRecipes = true
                            }, label: {
                                VStack(alignment: .leading, spacing: 3) {
                                    ForEach(0..<3) { i in
                                        Capsule()
                                            .frame(width: i == 1 ? 14 : 20, height: 4)
                                    }
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .background(Circle().strokeBorder(Color.gray.opacity(0.3), lineWidth: 1))
                            })
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Image(systemName: "bookmark")
                                    .font(.system(size: 19, weight: .bold))
                                    .foregroundStyle(Color.black)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .background(Circle().strokeBorder(Color.gray.opacity(0.3), lineWidth: 1))
                                          
                            })
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: 0) {
                            Text("데일리")
                                .font(.system(size: 27, weight: .bold))
                            
                            Text("레시피")
                                .font(.system(size: 27))
                        }
                    }
                    
                    Divider()
                        .padding(.top, 8)
                    
                    Text("오늘의 요리는 무엇인가요?")
                        .font(.system(size: 27, weight: .bold))
                        .padding(.top, 30)
                        .padding(.leading)
                    
                    HStack(spacing: 15) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 27, weight: .bold))
                            .foregroundStyle(.gray)
                        
                        TextField("예시 '새우두부계란찜'",
                                  text: $search,
                                  onEditingChanged: { edit in
                                    print("edit = \(edit)")
                                },
                                  onCommit: {
                                            Task {
                                            await viewModel.fetchRecipes(for: search)
                                            showSearchResult = true
                                            }
                                })
                        .font(.system(size: 21))
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius:
                                                    10).strokeBorder(Color.gray.opacity(0.3), lineWidth: 1))
                    .padding(.top)
                    .padding(.horizontal)
                    
                    .navigationDestination(isPresented: $showSearchResult) {
                        ResultView(recipes: viewModel.recipes)
                    }

                }
            })
            .sheet(isPresented: $showSavedRecipes) {
                SavedRecipesView()
            }
        }
    }
}

#Preview {
    SearchView()
}
