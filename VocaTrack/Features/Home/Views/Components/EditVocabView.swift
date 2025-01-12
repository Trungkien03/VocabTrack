//
//  EditVocabView.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import SwiftUI

struct EditVocabView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var vocabulary: Vocabulary

    var body: some View {
        Form {
            Section(header: Text("Word Details")) {
                TextField("Word", text: $vocabulary.word)
                TextField("Meaning", text: $vocabulary.meaning, axis: .vertical)
                    .lineLimit(3 ... 5)
            }

            Section(header: Text("Difficulty")) {
                Picker("Difficulty", selection: $vocabulary.difficulty) {
                    Text("Easy").tag("Easy")
                    Text("Medium").tag("Medium")
                    Text("Hard").tag("Hard")
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Section(header: Text("Favorite")) {
                Toggle("Mark as Favorite", isOn: $vocabulary.isFavorite)
            }
        }
        .navigationTitle("Edit Vocabulary")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    saveChanges()
                }
            }
        }
    }

    private func saveChanges() {
        vocabulary.updatedAt = Date()
        dismiss()
    }
}
