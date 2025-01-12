//
//  File.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import Foundation
import SwiftData

@Model
class User {
    @Attribute(.unique) var id: UUID
    var email: String
    var displayName: String
    var profileImage: String // URL
    var dateOfBirth: Date
    var phoneNumber: String
    var address: String
    var isPremium: Bool
    var createdAt: Date
    var updatedAt: Date
    var bio: String
    var language: String

    init(id: UUID = UUID(), email: String, displayName: String, profileImage: String, dateOfBirth: Date,
         phoneNumber: String, address: String, isPremium: Bool, createdAt: Date, updatedAt: Date,
         bio: String, language: String)
    {
        self.id = id
        self.email = email
        self.displayName = displayName
        self.profileImage = profileImage
        self.dateOfBirth = dateOfBirth
        self.phoneNumber = phoneNumber
        self.address = address
        self.isPremium = isPremium
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.bio = bio
        self.language = language
    }
}
