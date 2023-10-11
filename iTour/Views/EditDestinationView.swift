//
//  EditDestinationView.swift
//  iTour
//
//  Created by Nowroz Islam on 10/10/23.
//

import SwiftData
import SwiftUI

struct EditDestinationView: View {
    @Environment(\.modelContext) private var context
    @Bindable var destination: Destination
    @State private var sightName: String = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details)
            DatePicker("Date", selection: $destination.date)
            
            Section {
                Picker("Select priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
            }
            
            Section("Sights") {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }
                .onDelete(perform: deleteSight)
                
                HStack {
                    TextField("Add sight", text: $sightName)
                    
                    Button("Add", action: add)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func add() {
        let trimmedSightName = sightName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmedSightName.isEmpty == false else { return }
        
        withAnimation {
            destination.sights.append(Sight(name: trimmedSightName))
            sightName = ""
        }
    }
    
    func deleteSight(at offsets: IndexSet) {
        offsets.forEach {
            let sight = destination.sights.remove(at: $0)
            context.delete(sight)
        }
    }
}

#Preview {
    do {
        let container = try ModelContainer(for: Destination.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        return NavigationStack {
            EditDestinationView(destination: Destination())
                .modelContainer(container)
        }
    } catch {
        fatalError("Failed to create container")
    }
}
