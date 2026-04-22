//
//  SavedChoreo.swift
//  Dance Me
//
//  Created by Nia Mitchell on 4/17/26.
//

import Foundation
import SwiftData

struct SavedChoreo: Identifiable {
    let id = UUID()
    var name: String
    let items: [ChoreoItem]

}
