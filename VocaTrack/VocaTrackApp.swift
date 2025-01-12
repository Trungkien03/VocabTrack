//
//  iTourApp.swift
//  iTour
//
//  Created by Trung Kiên Nguyễn on 29/4/24.
//

import SwiftData
import SwiftUI

@main
struct VocaTrackApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Vocabulary.self)
    }
}
