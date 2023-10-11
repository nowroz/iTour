//
//  Destination.swift
//  iTour
//
//  Created by Nowroz Islam on 10/10/23.
//

import Foundation
import SwiftData

@Model final class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    @Relationship(deleteRule: .cascade) var sights: [Sight]
    
    
    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2, sights: [Sight] = []) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
        self.sights = sights
    }
}
