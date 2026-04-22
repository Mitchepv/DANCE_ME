//
//  ChoreoItem.swift
//  Dance Me
//
//  Created by Nia Mitchell on 4/21/26.
//

import Foundation
import SwiftUI

struct ChoreoItem: Identifiable {
    let id = UUID()
    let image: UIImage?
    let assetName: String?

    init(assetName: String) {
        self.assetName = assetName
        self.image = nil
    }

    init(image: UIImage) {
        self.image = image
        self.assetName = nil
    }
}
