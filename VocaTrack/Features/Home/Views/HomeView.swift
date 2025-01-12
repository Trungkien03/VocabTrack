//
//  HomeView.swift
//  VocaTrack
//
//  Created by Trung Kiên Nguyễn on 12/1/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = SortDescriptor(\Vocabulary.name)
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            DestinationListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("Vocab Tracking")
                .navigationDestination(for: Vocabulary.self) { vocabulary in
                    EditAddVocabView(vocabulary: vocabulary)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: EditAddVocabView(vocabulary: Vocabulary(), isNewVocabulary: true)) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .searchable(text: $searchText)
        }
    }
}

#Preview {
    HomeView()
}
