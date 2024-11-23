import SwiftUI
import KFImageManager

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 메인 이미지
                KFImageManager().loadImage(url: recipe.ATT_FILE_NO_MAIN, placeholder: UIImage(systemName: "photo"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .clipped()
                
                // 레시피 제목
                Text(recipe.RCP_NM)
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                
                // 카테고리 및 기본 정보
                VStack(spacing: 10) {
                    HStack {
                        Label(recipe.RCP_PAT2, systemImage: "tag")
                        Spacer()
                        Label(recipe.RCP_WAY2, systemImage: "flame")
                    }
                    
                    // 영양 정보
                    HStack {
                        NutritionInfoView(title: "칼로리", value: recipe.INFO_ENG)
                        Divider()
                        NutritionInfoView(title: "탄수화물", value: recipe.INFO_CAR)
                        Divider()
                        NutritionInfoView(title: "단백질", value: recipe.INFO_PRO)
                        Divider()
                        NutritionInfoView(title: "지방", value: recipe.INFO_FAT)
                    }
                }
                .padding(.horizontal)
                
                // 재료 섹션
                VStack(alignment: .leading, spacing: 10) {
                    Text("재료")
                        .font(.title2)
                        .bold()
                    Text(recipe.RCP_PARTS_DTLS)
                        .font(.body)
                }
                .padding(.horizontal)
                
                // 조리 순서 섹션
                VStack(alignment: .leading, spacing: 15) {
                    Text("조리 순서")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    
                    ForEach(Array(recipe.cookingSteps.enumerated()), id: \.offset) { index, step in
                        VStack(alignment: .leading) {
                            Text("Step \(index + 1)")
                                .font(.headline)
                            
                            if !step.imageURL.isEmpty {
                                KFImageManager().loadImage(url: step.imageURL, placeholder: UIImage(systemName: "photo"))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 200)
                                    .clipped()
                            }
                            
                            Text(step.description)
                                .font(.body)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 영양 정보를 표시하는 보조 뷰
struct NutritionInfoView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.caption2)
                .bold()
        }
    }
}
