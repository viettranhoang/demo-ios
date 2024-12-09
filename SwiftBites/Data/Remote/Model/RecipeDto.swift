//
//  RecipeDto.swift
//  BaseIos
//
//  Created by Vit on 6/12/24.
//

struct RecipeDto: Decodable {
    var id: Int
    var name: String
    var ingredients: [String]
    var instructions: [String]
    var servings: Int
    var cuisine: String
    var cookTimeMinutes: Int
    var image: String
}
