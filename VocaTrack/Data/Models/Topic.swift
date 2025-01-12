//
//  Topic.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import Foundation
import SwiftData

@Model
class Topic {
    @Attribute(.unique) var id: UUID
    var name: String
    var topicDescription: String
    var createdAt: Date
    var updatedAt: Date
    var isFavorite: Bool
    var vocabularies: [Vocabulary] = []

    init(id: UUID = UUID(), name: String, topicDescription: String, createdAt: Date, updatedAt: Date, isFavorite: Bool) {
        self.id = id
        self.name = name
        self.topicDescription = topicDescription
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isFavorite = isFavorite
    }
}
