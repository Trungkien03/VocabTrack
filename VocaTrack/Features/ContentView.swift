//
//  ContentView.swift
//  iTour
//
//  Created by Trung Kiên Nguyễn on 29/4/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }

            NavigationView {
                VocabularyListView()
            }
            .tabItem {
                Label("Vocabulary", systemImage: "list.bullet")
            }

            NavigationView {
                QuizView()
            }
            .tabItem {
                Label("Quiz", systemImage: "questionmark.circle")
            }

            NavigationView {
                ProgressTrackView()
            }
            .tabItem {
                Label("Progress", systemImage: "chart.bar")
            }

            NavigationView {
                SettingView()
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}

#Preview {
    ContentView()
}
