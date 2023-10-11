//
//  DistanceListView.swift
//  iTour
//
//  Created by Nowroz Islam on 10/10/23.
//

import SwiftData
import SwiftUI

struct DistanceListView: View {
    @Environment(\.modelContext) private var context
    @Query private var destinations: [Destination]
    @Query private var sights: [Sight]
    
    var body: some View {
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
            .onDelete(perform: delete)
        }
    }
    
    init(sort: [SortDescriptor<Destination>], showUpcoming: Bool, searchString: String) {
        let now = Date.now
        let predicate = #Predicate<Destination> { destination in
            if showUpcoming {
                if searchString.isEmpty {
                    destination.date >= now
                } else {
                    destination.date >= now && destination.name.localizedStandardContains(searchString)
                }
            } else {
                if searchString.isEmpty {
                    true
                } else {
                    true && destination.name.localizedStandardContains(searchString)
                }
            }
        }
        _destinations = Query(FetchDescriptor(predicate: predicate, sortBy: sort))
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach {
            let destination = destinations[$0]
            context.delete(destination)
        }
    }
}

#Preview {
    DistanceListView(sort: [], showUpcoming: false, searchString: "")
        .modelContainer(previewContainer)
}
