//
//  VocabularyTopic.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import Foundation
import SwiftData

@Model
class VocabularyTopic {
    @Attribute(.unique) var id: UUID
    @Relationship var vocabulary: Vocabulary
    @Relationship var topic: Topic

    init(id: UUID = UUID(), vocabulary: Vocabulary, topic: Topic) {
        self.id = id
        self.vocabulary = vocabulary
        self.topic = topic
    }
}
