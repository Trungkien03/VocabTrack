//
//  VocabularyListView.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import SwiftUI

struct VocabularyListView: View {
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = SortDescriptor(\Vocabulary.meaning)
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            VocabularyListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("Vocabulary List")
                .navigationDestination(for: Vocabulary.self) { vocabulary in
                    EditVocabView(vocabulary: vocabulary)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddVocabularyView()) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .searchable(text: $searchText)
        }
    }
}

#Preview {
    VocabularyListView()
}
