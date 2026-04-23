//
//  ChoreographyViewModel.swift
//  Dance Me
//
//  Created by Nia Mitchell on 4/16/26.
//
import Foundation
import UIKit
import PhotosUI
import SwiftUI


@MainActor
@Observable

class ChoreographyViewModel {


    var choreography: [ChoreoItem] = []
    
    let moves: [String]
    var choreographyName: String = ""
    var savedChoreo: [SavedChoreo] = []
    
    init() {
            self.moves = [
                 "arm cover face", "arm and leg out", "arms out","ballerina-pose","ballet-pose","bend  left leg right arm hold head","bend arm down and point up","bend kness in bend right arm up", "bend left leg and right arm left arm up","bend right leg left arm hold head","both arm on right","both arm up body left","both arm up body right","dance","dancing-man-posture","dancing","feet","female-flamenco-dancer","flamenco-dancer","flamenco-male-dancer-silhouettes","fornite dance 2","fornite dance 3","fornite dance 4","fornite dance 5",  "fortnite dance 1", "hand (1)", "hand","hello","i-love-you","ok","peace","people","people (1)","people (2)","person","squat  right arms bend and turn right","squat arm right","stand on right arm and leg left leg out","steo right","step back","step forward", "victory", "yoga-pose"]
        }



    func removeMove(at index: Int) {
        choreography.remove(at: index)
    }

    func remove(at index: Int) {
        guard choreography.indices.contains(index) else { return }
        choreography.remove(at: index)
    }
    
    func toggleMove(_ move: String) {
        if let index = choreography.firstIndex(where: { $0.assetName == move }) {
              choreography.remove(at: index)
          } else {

              choreography.append(ChoreoItem(assetName: move))
          }
      }
    
    func saveChoreo(name: String) {
        guard !choreography.isEmpty else { return }

        let newChoreo = SavedChoreo(
            name: name.isEmpty ? "Untitled" : name,
            items: choreography 
        )
        savedChoreo.append(newChoreo)
        choreography.removeAll()
        choreographyName = ""
    }
    
    func addPhoto(from item: PhotosPickerItem?) async {
        guard let item else { return }

        if let data = try? await item.loadTransferable(type: Data.self),
           let image = UIImage(data: data) {

            choreography.append(ChoreoItem(image: image))
        }
    }
    
    func addAsset(_ name: String) {
        choreography.append(ChoreoItem(assetName: name))
    }

    func addImage(_ image: UIImage) {
        choreography.append(ChoreoItem(image: image))
    }

  
 
}
