//
//  RandomRecipeView.swift
//  DailyCook
//
//  Created by 이영호 on 11/23/24.
//

import SwiftUI
import SDUIManager

// 사용 예시


struct RandomRecipeView: View {
    
    @State private var component: SDUIComponent?
    
    var body: some View {
        Group {
            if let component = component {
                SDUIRenderer.render(component)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            loadUIFromJSON()
        }
    }
    
    private func loadUIFromJSON() {
        // 1. Bundle에서 JSON 파일 로드
        if let url = Bundle.main.url(forResource: "UITEST", withExtension: "json"),
           let jsonData = try? Data(contentsOf: url) {
            do {
                // 2. JSON 데이터를 SDUIComponent로 파싱
                let component = try SDUIParser.parse(jsonData: jsonData)
                self.component = component
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }
}


//import SwiftUI
//import SDUIManager // 우리가 만든 SDUI 모듈
//
//struct ContentView: View {
//    @State private var component: SDUIComponent?
//    
//    var body: some View {
//        Group {
//            if let component = component {
//                SDUIRenderer.render(component)
//            } else {
//                ProgressView()
//            }
//        }
//        .onAppear {
//            loadUIFromJSON()
//        }
//    }
//    
//    private func loadUIFromJSON() {
//        // 1. Bundle에서 JSON 파일 로드
//        if let url = Bundle.main.url(forResource: "main_view", withExtension: "json"),
//           let jsonData = try? Data(contentsOf: url) {
//            do {
//                // 2. JSON 데이터를 SDUIComponent로 파싱
//                let component = try SDUIParser.parse(jsonData: jsonData)
//                self.component = component
//            } catch {
//                print("Error parsing JSON: \(error)")
//            }
//        }
//    }
//}
//struct RecipeThumbView: View {
//    var recipe: Recipe
//
////    var body: some View {
////
////    }
//}

#Preview {
    RandomRecipeView()
}
