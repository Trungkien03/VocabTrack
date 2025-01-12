//
//  HomeView.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var isNavigateToAddWord = false
    @Binding var tab: Tab

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Quick Stats
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Today's Stats")
                            .font(.headline)
                            .padding(.bottom, 5)
                        HStack {
                            StatView(title: "Words Learned", value: "15")
                            StatView(title: "Words Reviewed", value: "8")
                            StatView(title: "Total Words", value: "120")
                        }
                    }
                    .padding(.vertical)

                    // Quick Actions
                    VStack(alignment: .leading) {
                        Text("Quick Actions")
                            .font(.headline)
                            .padding(.bottom, 5)
                        HStack {
                            QuickActionButton(icon: "plus", title: "Add Word") {
                                isNavigateToAddWord = true
                            }

                            QuickActionButton(icon: "bolt", title: "Start Quiz") {
                                tab = .quiz
                            }

                            QuickActionButton(icon: "list.bullet", title: "Vocabulary List") {
                                tab = .vocabulary
                            }
                        }
                    }
                    .padding(.vertical)

                    Spacer()
                }
                .navigationTitle("Home")
                .searchable(text: $searchText)
                .navigationDestination(isPresented: $isNavigateToAddWord) {
                    AddVocabularyView()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        UserProfileImage()
                    }
                }
                .padding()
            }
        }
    }
}

// MARK: - Supporting Views

struct StatView: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            Text(value)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(title)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }, label: {
            VStack {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding()
                    .background(Circle().fill(Color.blue.opacity(0.2)))
                Text(title)
                    .font(.subheadline)
            }
        })
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HomeView(tab: .constant(.home))
}
