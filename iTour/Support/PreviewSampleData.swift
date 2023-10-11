//
//  PreviewSampleData.swift
//  iTour
//
//  Created by Nowroz Islam on 10/10/23.
//

import Foundation
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: Destination.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        if try container.mainContext.fetch(FetchDescriptor<Destination>()).isEmpty {
            SampleData.contents.forEach { container.mainContext.insert($0) }
        }
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
