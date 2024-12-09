//
//  Recipe.swift
//  SwiftBites
//
//  Created by Vit on 3/11/24.
//
import Foundation
import SwiftData

@Model
final class Recipe: Identifiable, Hashable {
    var id: UUID
    @Attribute(.unique)
    var name: String
    var summary: String
    
    @Relationship(deleteRule: .nullify, inverse: \Category.recipes)
    var category: Category?

    var serving: Int
    var time: Int
    
    @Relationship(deleteRule: .cascade, inverse: \RecipeIngredient.recipe)
    var ingredients: [RecipeIngredient]
    var instructions: String
    var imageData: Data?
    
    init(
        id: UUID = UUID(),
        name: String = "",
        summary: String = "",
        category: Category? = nil,
        serving: Int = 1,
        time: Int = 5,
        ingredients: [RecipeIngredient] = [],
        instructions: String = "",
        imageData: Data? = nil
    ) {
        self.id = id
        self.name = name
        self.summary = summary
        self.category = category
        self.serving = serving
        self.time = time
        self.ingredients = ingredients
        self.instructions = instructions
        self.imageData = imageData
    }
}

@Model
final class RecipeIngredient: Identifiable, Hashable {
    var id: UUID
    @Relationship()
    var ingredient: Ingredient? = nil
    var quantity: String
    
    @Relationship()
    var recipe: Recipe? = nil
    
    init(id: UUID = UUID(), quantity: String = "") {
        self.id = id
        self.quantity = quantity
    }
}
