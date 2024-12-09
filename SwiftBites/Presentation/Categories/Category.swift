//
//  Category.swift
//  SwiftBites
//
//  Created by Vit on 3/11/24.
//
import Foundation
import SwiftData

@Model
final class Category: Identifiable, Hashable {
    var id: UUID
    @Attribute(.unique)
    var name: String
    
    @Relationship(deleteRule: .nullify)
    var recipes: [Recipe]
    
    init(id: UUID = UUID(), name: String = "", recipes: [Recipe] = []) {
        self.id = id
        self.name = name
        self.recipes = recipes
    }
}
