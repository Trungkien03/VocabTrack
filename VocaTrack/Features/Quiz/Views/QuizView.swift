//
//  QuizView.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import SwiftUI

struct QuizView: View {
    @State private var currentWord: String = "Hello"
    @State private var showMeaning: Bool = false
    @State private var options = ["World", "Greetings", "Hello", "Bye"]

    var body: some View {
        VStack(spacing: 20) {
            // Flashcard
            VStack {
                Text(currentWord)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                if showMeaning {
                    Text("A common greeting.")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.1)))
            .onTapGesture {
                withAnimation {
                    showMeaning.toggle()
                }
            }

            // Quiz Options
            VStack(alignment: .leading) {
                Text("Choose the correct meaning:")
                    .font(.headline)
                ForEach(options, id: \.self) { option in
                    Button {
                        print("Selected: \(option)")
                    } label: {
                        Text(option)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                    }
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Quiz")
    }
}

#Preview {
    QuizView()
}
