import SwiftUI

struct SavedRecipesView: View {
    @State private var savedRecipes: [Recipe] = []
    private let dataManager = DataManager<Recipe>()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                ForEach(savedRecipes.indices, id: \.self) { index in
                    NavigationLink(destination: RecipeDetailView(recipe: savedRecipes[index])) {
                        HStack {
                            AsyncImage(url: URL(string: savedRecipes[index].ATT_FILE_NO_MAIN)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            Text(savedRecipes[index].RCP_NM)
                                .font(.body)
                                .padding(.leading, 8)
                        }
                    }
                }
                .onDelete(perform: deleteRecipes)
            }
            .navigationTitle("저장된 레시피")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("닫기") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                loadSavedRecipes()
            }
        }
    }
    
    private func loadSavedRecipes() {
        savedRecipes = dataManager.loadItem(forKey: "savedRecipes")
    }
    
    private func deleteRecipes(at offsets: IndexSet) {
        // 선택된 레시피들 삭제
        savedRecipes.remove(atOffsets: offsets)
        // 변경된 레시피 목록 저장
        dataManager.saveItem(savedRecipes, forKey: "savedRecipes")
    }
}

#Preview {
    SavedRecipesView()
}
