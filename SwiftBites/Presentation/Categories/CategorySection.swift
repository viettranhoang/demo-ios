import SwiftUI
import SwiftData

struct CategorySection: View {
    
    var category: Category
    
    @Query
    private var recipes: [Recipe]
    
    private var filteredRecipes: [Recipe] {
        recipes.filter { recipe in
            recipe.category == category
            }
        }
    
   
    // MARK: - Body
    
    var body: some View {
        Section(
            content: {
                if filteredRecipes.isEmpty {
                    empty
                } else {
                    list
                }
            },
            header: {
                HStack(alignment: .center) {
                    Text(category.name)
                        .font(.title)
                        .bold()
                    Spacer()
                    NavigationLink("Edit", value: CategoryForm.Mode.edit(category))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
        )
    }
    
    // MARK: - Views
    
    var list: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(filteredRecipes, id: \.name) { recipe in
                    RecipeCell(recipe: recipe)
                        .containerRelativeFrame(.horizontal, count: 12, span: 11, spacing: 0)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
    }
    
    var empty: some View {
        ContentUnavailableView(
            label: {
                Label("No Recipes", systemImage: "list.clipboard")
            },
            description: {
                Text("Recipes you add will appear here.")
            },
            actions: {
                NavigationLink("Add Recipe", value: RecipeForm.Mode.add)
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.bordered)
            }
        )
    }
}

