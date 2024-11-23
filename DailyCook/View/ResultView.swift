import SwiftUI
import KFImageManager

struct ResultView: View {
    @State var recipes: [Recipe] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Text("결과")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        RecipeRowView(recipe: recipe)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Divider()
                        .padding(.horizontal)
                }
            }
        }
    }
}

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.RCP_NM)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(recipe.RCP_PAT2)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                    Text("10 minutes")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.top, 4)
            }
            
            Spacer()
            
            KFImageManager().loadImage(url: recipe.ATT_FILE_NO_MAIN, placeholder: UIImage(systemName: "photo"))
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding()
    }
}

#Preview {
    ResultView(recipes: [])
}
