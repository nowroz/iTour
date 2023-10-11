//
//  Sight.swift
//  iTour
//
//  Created by Nowroz Islam on 10/10/23.
//

import Foundation
import SwiftData

@Model final class Sight {
    var name: String
    
    init(name: String = "") {
        self.name = name
    }
}
