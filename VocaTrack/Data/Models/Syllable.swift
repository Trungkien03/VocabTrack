//
//  Syllable.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import Foundation
import SwiftData

@Model
final class Syllable {
    @Attribute(.unique) var id: UUID
    var content: String
    var pronunciation: String

    @Relationship var vocabulary: Vocabulary // Loại bỏ inverse để tránh lỗi vòng lặp

    init(content: String, pronunciation: String, vocabulary: Vocabulary) {
        self.id = UUID() // Tạo UUID duy nhất
        self.content = content // Gán nội dung âm tiết
        self.pronunciation = pronunciation // Gán phiên âm của âm tiết
        self.vocabulary = vocabulary // Liên kết tới từ vựng
    }

    // Hàm cập nhật thông tin âm tiết
    func update(content: String? = nil, pronunciation: String? = nil) {
        if let content = content { self.content = content }
        if let pronunciation = pronunciation { self.pronunciation = pronunciation }
    }
}
