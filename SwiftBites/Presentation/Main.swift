import SwiftUI

/// The main view that appears when the app is launched.
struct ContentView: View {
    
    var body: some View {
        TabView {
            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "frying.pan")
                }
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass.circle.fill")
                }
            
            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "tag")
                }
            
            IngredientsView()
                .tabItem {
                    Label("Ingredients", systemImage: "carrot")
                }
        }
        .onAppear {
            
        }
    }
}

#Preview {
    ContentView()
}
