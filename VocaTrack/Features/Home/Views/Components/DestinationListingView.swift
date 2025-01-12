//
//  DestinationListingView.swift
//  iTour
//
//  Created by Trung Kiên Nguyễn on 29/4/24.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Vocabulary.priority, order: .reverse), SortDescriptor(\Vocabulary.name)]) var destinations: [Vocabulary]
    
    var body: some View {
        Group {
            if destinations.isEmpty {
                Text("No destinations available. Add some!")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                List {
                    ForEach(destinations) { destination in
                        NavigationLink(value: destination) {
                            VStack(alignment: .leading) {
                                Text(destination.name)
                                    .font(.headline)
                                Text(destination.date.formatted(date: .long, time: .shortened))
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
                return $0.name.localizedStandardContains(searchString)
            }
        } ,sort: [sort])
    }
    
    func deleteDestination(_ indexSet: IndexSet){
        for index in indexSet {
            let desination = destinations[index]
            modelContext.delete(desination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Vocabulary.name), searchString: "")
}
