import SwiftData
import SwiftUI

struct VocabularyListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Vocabulary.createdAt, order: .reverse), SortDescriptor(\Vocabulary.meaning)]) var destinations: [Vocabulary]
    @State private var selectedVocabulary: Vocabulary?

    var body: some View {
        VStack {
            if destinations.isEmpty {
                Text("No destinations available. Add some!")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                List {
                    ForEach(destinations) { destination in
                        NavigationLink(destination: EditVocabView(vocabulary: destination)) {
                            VStack(alignment: .leading) {
                                Text(destination.meaning)
                                    .font(.headline)
                                Text(destination.createdAt.formatted(date: .long, time: .shortened))
                            }
                        }
                    }
                    .onDelete(perform: deleteDestination)
                }
            }
        }
    }

    init(sort: SortDescriptor<Vocabulary>, searchString: String) {
        _destinations = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.meaning.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }

    func deleteDestination(_ indexSet: IndexSet) {
        for index in indexSet {
            let desination = destinations[index]
            modelContext.delete(desination)
        }
    }
}

#Preview {
    VocabularyListingView(sort: SortDescriptor(\Vocabulary.meaning), searchString: "")
}
