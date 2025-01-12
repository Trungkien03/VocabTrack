//
//  ContentView.swift
//  iTour
//
//  Created by Trung Kiên Nguyễn on 29/4/24.
//

import SwiftData
import SwiftUI

enum Tab: Hashable {
    case home
    case vocabulary
    case quiz
    case progress
    case setting
}

struct ContentView: View {
    @State var tab: Tab = .home

    var body: some View {
        TabView(selection: $tab) {
            HomeView(tab: $tab)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            VocabularyListView()
                .tabItem {
                    Label("Vocabulary", systemImage: "list.bullet")
                }

            QuizView()
                .tabItem {
                    Label("Quiz", systemImage: "square.stack.3d.up.badge.automatic.fill")
                }

            ProgressTrackView()
                .tabItem {
                    Label("Progress", systemImage: "chart.bar")
                }

            SettingView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
}
