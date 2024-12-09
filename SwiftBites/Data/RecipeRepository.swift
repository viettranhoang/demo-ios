//
//  RecipeRepository.swift
//  BaseIos
//
//  Created by Vit on 6/12/24.
//

protocol RecipeRepository {
    
    func fetchExplore() async -> [RecipeDto]
}

class RecipeRepositoryImpl: RecipeRepository {
    private var recipeRemote: RecipeRemote = RecipeRemoteImpl()
    
    func fetchExplore() async -> [RecipeDto] {
        do {
            return try await recipeRemote.fetchExplore()
        } catch {
            print(error)
            return []
        }
    }
}
