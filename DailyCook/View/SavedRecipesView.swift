import SwiftUI

struct SavedRecipesView: View {
    @State private var savedRecipes: [Recipe] = []
    private let dataManager = DataManager<Recipe>()
    
    var body: some View {
        NavigationView {
            List(savedRecipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    HStack {
                        AsyncImage(url: URL(string: recipe.ATT_FILE_NO_MAIN)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Text(recipe.RCP_NM)
                            .font(.body)
                            .padding(.leading, 8)
                    }
                }
            }
            .navigationTitle("저장된 레시피")
            .onAppear {
                loadSavedRecipes()
            }
        }
    }
    
    private func loadSavedRecipes() {
        savedRecipes = dataManager.loadItem(forKey: "savedRecipes")
    }
}

#Preview {
    SavedRecipesView()
}
