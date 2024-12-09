//
//  Ingredient.swift
//  SwiftBites
//
//  Created by Vit on 3/11/24.
//
import Foundation
import SwiftData

@Model
final class Ingredient: Identifiable, Hashable {
    var id: UUID
    @Attribute(.unique)
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \RecipeIngredient.ingredient)
    var recipeIngredients: [RecipeIngredient] = []
    
    init(id: UUID = UUID(), name: String = "") {
        self.id = id
        self.name = name
    }
}

