//
//  ExploreViewModel.swift
//  BaseIos
//
//  Created by Vit on 6/12/24.
//

import SwiftUI

@Observable
class ExploreViewModel {
    
    var recipes: [Recipe] = []
    
    private let recipeRepository: RecipeRepository = RecipeRepositoryImpl()
    
    func fetchExplore() async {
        let result = await recipeRepository.fetchExplore()
        recipes = result.toRecipe()
    }
}

extension RecipeDto {
    func toRecipe() -> Recipe {
        return Recipe(
            id: UUID(),
            name: self.name,
            summary: self.name,
            serving: self.servings,
            time: self.cookTimeMinutes,
            instructions: self.instructions.joined(separator: "\n")
        )
    }
}

extension Array where Element == RecipeDto {
    func toRecipe() -> [Recipe] {
        return self.map { $0.toRecipe() }
    }
}

