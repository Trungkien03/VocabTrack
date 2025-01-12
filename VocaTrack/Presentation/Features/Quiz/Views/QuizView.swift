//
//  QuizView.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import SwiftUI

struct QuizView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("No flashcards yet")
                        .fontWeight(.bold)
                }
            }
            .padding()
            .navigationTitle("Quiz")
        }
    }
}

#Preview {
    QuizView()
}
