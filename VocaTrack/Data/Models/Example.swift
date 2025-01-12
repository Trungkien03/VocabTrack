//
//  Example.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import Foundation
import SwiftData

@Model
class Example {
    @Attribute(.unique) var id: UUID
    var content: String
    var translation: String
    var exampleType: String
    @Relationship var vocabulary: Vocabulary

    init(id: UUID = UUID(), content: String, translation: String, exampleType: String, vocabulary: Vocabulary) {
        self.id = id
        self.content = content
        self.translation = translation
        self.exampleType = exampleType
        self.vocabulary = vocabulary
    }
}
