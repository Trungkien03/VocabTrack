//
//  VocaTrackApp.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 29/4/24.
//

import SwiftData
import SwiftUI

@main
struct VocaTrackApp: App {
//    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .modelContainer(for: [User.self, Vocabulary.self, Topic.self, Syllable.self, Example.self, VocabularyTopic.self])
        }
    }
}
