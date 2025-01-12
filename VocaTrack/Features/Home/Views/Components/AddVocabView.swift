//
//  EditDestinationView.swift
//  iTour
//
//  Created by Trung Kiên Nguyễn on 29/4/24.
//

import SwiftData
import SwiftUI

struct AddVocabularyView: View {
    @Environment(\.dismiss) var dismiss
    @State private var word: String = ""
    @State private var meaning: String = ""
    @State private var difficulty: String = "Easy"
    @State private var isFavorite: Bool = false
    @State private var topics: [String] = []
    @State private var newTopic: String = ""
    @State private var examples: [String] = []
    @State private var newExample: String = ""

    let difficultyLevels = ["Easy", "Medium", "Hard"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Word Details")) {
                    TextField("Word", text: $word)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    TextField("Meaning", text: $meaning, axis: .vertical)
                        .lineLimit(2 ... 5)
                }

                Section(header: Text("Difficulty")) {
                    Picker("Difficulty", selection: $difficulty) {
                        ForEach(difficultyLevels, id: \.self) { level in
                            Text(level).tag(level)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Favorite")) {
                    Toggle("Mark as Favorite", isOn: $isFavorite)
                }

                Section(header: Text("Topics")) {
                    ForEach(topics, id: \.self) { topic in
                        Text(topic)
                    }
                    .onDelete(perform: deleteTopic)

                    HStack {
                        TextField("Add a topic", text: $newTopic)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        Button(action: addTopic) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }

                Section(header: Text("Examples")) {
                    ForEach(examples, id: \.self) { example in
                        Text(example)
                    }
                    .onDelete(perform: deleteExample)

                    HStack {
                        TextField("Add an example", text: $newExample)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        Button(action: addExample) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            .navigationTitle("Add Vocabulary")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveVocabulary()
                    }
                    .disabled(word.isEmpty || meaning.isEmpty)
                }
            }
        }
    }

    // MARK: - Functions

    private func addTopic() {
        guard !newTopic.isEmpty else { return }
        topics.append(newTopic)
        newTopic = ""
    }

    private func deleteTopic(at offsets: IndexSet) {
        topics.remove(atOffsets: offsets)
    }

    private func addExample() {
        guard !newExample.isEmpty else { return }
        examples.append(newExample)
        newExample = ""
    }

    private func deleteExample(at offsets: IndexSet) {
        examples.remove(atOffsets: offsets)
    }

    private func saveVocabulary() {
        // Logic to save vocabulary to your data model
        print("Saved word: \(word), meaning: \(meaning), difficulty: \(difficulty), favorite: \(isFavorite)")
        print("Topics: \(topics)")
        print("Examples: \(examples)")
        dismiss()
    }
}
