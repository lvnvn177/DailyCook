//
//  ResultView.swift
//  DailyCook
//
//  Created by 이영호 on 11/23/24.
//

import SwiftUI
import KFImageManager

struct ResultView: View {
    @State var recipes: [Recipe] = [] // Use @State or a ViewModel

    var body: some View {
        ScrollView {
            ForEach(recipes) { recipe in
                HStack {
                    KFImageManager().loadImage(url: recipe.ATT_FILE_NO_MAIN ?? "", placeholder: UIImage(systemName: "photo"))
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())

                    VStack(alignment: .leading) {
                        Text(recipe.RCP_NM)
                            .font(.headline)
                        Text(recipe.RCP_PAT2)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}

//#Preview {
//    ResultView(recipes: <#[Recipe]#>)
//}
