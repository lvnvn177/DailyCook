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
    
    func fetchRecipes(for query: String) {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "APIKEY") as! String
        let baseURL = "http://openapi.foodsafetykorea.go.kr/api/\(apiKey)/COOKRCP01/json/1/10"
        let parameters: [String: Any] = ["RCP_NM": query]
        print(query)
        print(parameters)
        print(apiKey)
        apiManager.request(url: baseURL, parameters: parameters, headers: [:]) { (result: Result<RecipeRespose, Error>) in
            switch result {
            case .success(let response):
                self.recipes = response.data.list // API의 데이터 파싱
            case .failure(let error):
                print("Error fetching recipes: \(error)")
            }
        }
    }
}
