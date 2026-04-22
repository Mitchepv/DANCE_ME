//
//  SavedChoreographyView.swift
//  Dance Me
//
//  Created by Nia Mitchell on 4/21/26.
//

import SwiftUI

struct SavedChoreographyView: View {
    
    let choreo: SavedChoreo
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
       
    
        VStack(alignment: .center){
            Spacer()
            Spacer()
            Spacer()
            
            Text(choreo.name)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.purple)
                .padding(10)
            
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))],spacing: 12) {
                        ForEach(choreo.items) { move in
                            if let image = move.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                
                            } else if let name = move.assetName {
                                Image(name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                .padding()
            }
        }
    }
}

#Preview {
    NavigationStack{
        SavedChoreographyView(choreo: SavedChoreo(name: "one",items: [ ChoreoItem(assetName:"arms out"),
            ChoreoItem(assetName:"dance"),
           ChoreoItem(assetName:"arm cover face"),
          ChoreoItem(assetName:"arm and leg out"),
          ChoreoItem(assetName:"ballerina-pose"),
          ChoreoItem(assetName:"ballet-pose"),
        ChoreoItem(assetName:"bend  left leg right arm hold head")]
            )
        )
    }
}
