//
//  ContentView.swift
//  iTour
//
//  Created by Nowroz Islam on 10/10/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var path: [Destination] = []
    @State private var sortBy: [SortDescriptor<Destination>] = [
        SortDescriptor(\Destination.name),
        SortDescriptor(\Destination.priority, order: .reverse)
    ]
    @State private var showUpcoming: Bool = false
    @State private var searchString: String = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            DistanceListView(sort: sortBy, showUpcoming: showUpcoming, searchString: searchString)
                .navigationTitle("iTour")
                .navigationDestination(for: Destination.self) {
                    EditDestinationView(destination: $0)
                }
                .searchable(text: $searchString, prompt: "Search destinations")
                .toolbar {
                    ToolbarItem {
                        Menu("Sort by", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort by", selection: $sortBy) {
                                Text("Name").tag([
                                    SortDescriptor(\Destination.name),
                                    SortDescriptor(\Destination.priority, order: .reverse)
                                ])
                                Text("Date").tag([
                                    SortDescriptor(\Destination.date),
                                    SortDescriptor(\Destination.name)
                                ])
                                Text("Priority").tag([
                                    SortDescriptor(\Destination.priority, order: .reverse),
                                    SortDescriptor(\Destination.date)
                                ])
                            }
                            .pickerStyle(.inline)
                        }
                    }
                    
                    ToolbarItem {
                        Menu("Sort by", systemImage: "ellipsis") {
                            Picker("Show", selection: $showUpcoming) {
                                Text("All").tag(false)
                                Text("Upcoming").tag(true)
                            }
                            .pickerStyle(.inline)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Add destination", systemImage: "plus", action: add)
                    }
                }
        }
    }
    
    func add() {
        let newDestination = Destination()
        context.insert(newDestination)
        path = [newDestination]
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
