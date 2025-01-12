//
//  Destination.swift
//  iTour
//
//  Created by Trung Kiên Nguyễn on 29/4/24.
//

import Foundation
import SwiftData

@Model
class Vocabulary {
    @Attribute(.unique) var id: UUID
    var word: String
    var meaning: String
    var synonyms: [String]
    var antonyms: [String]
    var examples: [String]
    var difficulty: String
    var createdAt: Date
    var updatedAt: Date
    var isFavorite: Bool
    var topics: [Topic] = []
    @Relationship var user: User

    init(id: UUID = UUID(), word: String, meaning: String, synonyms: [String], antonyms: [String], examples: [String],
         difficulty: String, createdAt: Date, updatedAt: Date, isFavorite: Bool, user: User)
    {
        self.id = id
        self.word = word
        self.meaning = meaning
        self.synonyms = synonyms
        self.antonyms = antonyms
        self.examples = examples
        self.difficulty = difficulty
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isFavorite = isFavorite
        self.user = user
    }
}
