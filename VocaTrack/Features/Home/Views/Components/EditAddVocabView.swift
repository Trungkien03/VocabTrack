//
//  EditDestinationView.swift
//  iTour
//
//  Created by Trung Kiên Nguyễn on 29/4/24.
//

import SwiftUI
import SwiftData

struct EditAddVocabView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    @Bindable var vocabulary: Vocabulary
    var isNewVocabulary: Bool = false
    @State private var newSightName = ""

    var body: some View {
     
            Form {
                Section(header: Text("Vocabulary Info")) {
                    TextField("Name", text: $vocabulary.name)
                    TextField("Details", text: $vocabulary.details, axis: .vertical)
                        .lineLimit(3...5)
                    DatePicker("Date", selection: $vocabulary.date, displayedComponents: .date)
                }

                Section(header: Text("Priority")) {
                    Picker("Priority", selection: $vocabulary.priority) {
                        Text("Low").tag(1)
                        Text("Medium").tag(2)
                        Text("High").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Sights")) {
                    ForEach(vocabulary.sights) { sight in
                        Text(sight.name)
                    }
                    .onDelete(perform: deleteSight)

                    HStack {
                        TextField("Add a new sight", text: $newSightName)
                        Button(action: addSight) {
                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
            .navigationTitle(isNewVocabulary ? "Add Vocabulary" : "Edit Vocabulary")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                   // Leading button
                   ToolbarItem(placement: .navigationBarLeading) {
                       Button(action: {
                           cancel()
                       }) {
                           Text("Cancel")
                       }
                   }
                   // Trailing button
                   ToolbarItem(placement: .navigationBarTrailing) {
                       Button("Save") {
                           saveVocabulary()
                       }
                   }
               }
        
    }

    func addSight() {
        guard !newSightName.isEmpty else { return }
        let sight = Sight(name: newSightName)
        vocabulary.sights.append(sight)
        newSightName = ""
    }

    func deleteSight(at offsets: IndexSet) {
        vocabulary.sights.remove(atOffsets: offsets)
    }

    func saveVocabulary() {
        // Save logic, handled externally if needed
    }

    func cancel() {
        dismiss()
    }
}
