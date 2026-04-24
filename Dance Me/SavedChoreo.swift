//
//  SavedChoreo.swift
//  Dance Me
//
//  Created by Nia Mitchell on 4/17/26.
//

import Foundation
import SwiftData



struct SavedChoreo: Identifiable {
    var id = UUID() 
    var name: String
    let items: [ChoreoItem]
    
    init(id: UUID = UUID(), name: String, items: [ChoreoItem]) {
            self.id = id
            self.name = name
            self.items = items
        }

}
