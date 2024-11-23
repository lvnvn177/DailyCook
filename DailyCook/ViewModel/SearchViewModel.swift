//
//  SearchViewModel.swift
//  DailyCook
//
//  Created by 이영호 on 11/23/24.
//


import Foundation
import ApiManager

@MainActor
class SearchViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    private let apiManager = ApiManager()
    
    func fetchRecipes(for query: String) async {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "APIKEY") as! String
        
        // URL 인코딩
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        
        // 검색어를 URL에 직접 포함
        let baseURL = "http://openapi.foodsafetykorea.go.kr/api/\(apiKey)/COOKRCP01/json/1/10/RCP_NM=\(encodedQuery)"
        
        do {
            let result: RecipeRespose = try await withCheckedThrowingContinuation { continuation in
                apiManager.request(
                    url: baseURL,
                    parameters: nil, // 파라미터를 URL에 직접 포함했으므로 nil
                    headers: [:]) { (result: Result<RecipeRespose, Error>) in
                        continuation.resume(with: result)
                    }
            }
            
            if let recipes = result.COOKRCP01.row {
                self.recipes = recipes
            } else {
                self.recipes = []
            }
        } catch {
            print("Error fetching recipes: \(error)")
            self.recipes = []
        }
    }
}
