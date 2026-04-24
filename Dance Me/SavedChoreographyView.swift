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
    @State private var showItems = false
    
    var body: some View {
       
    
        VStack(alignment: .center, spacing: 20){
            
            Spacer()
            Spacer()
            
            Text(choreo.name)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.black)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.purple.opacity(0.8))
                )
 
            
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                    ForEach(Array(choreo.items.enumerated()), id: \.element.id) { index, item in
                        Group {
                            if let image = item.image {
                                Image(uiImage: image )
                                    .resizable()
                                    .scaledToFit()
                                    .background(.blue.opacity(0.2))

                            } else if let name = item.assetName {
                                Image(name)
                                    .resizable()
                                    .scaledToFit()
                                    .background(.blue.opacity(0.2))
                            }
                        }
                        .frame(width: 50, height: 50)
                        .scaleEffect(showItems ? 1 : 0.2)
                        .opacity(showItems ? 1 : 0)
                        .animation(
                            .spring(response: 0.9, dampingFraction: 0.85)
                            .delay(Double(index) * 0.35),
                            value: showItems
                        )
                    }
                }
                .padding(10)
                Spacer()
            }
            .background(.purple.opacity(0.1))
            .frame(maxWidth: .infinity, alignment: .top)
            
            Button {
                showItems = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                showItems = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                       showItems = false
                   }

            } label: {
                Text("Play your Choreography")
                    .font(.headline)
                    .padding()
                    .background(.purple)
                    .tint(.black)
                    .bold()
                    .cornerRadius(10)
            }
          
            Image("launchScreen")
                .resizable()
                .scaledToFit()
                .padding(.bottom)
           
        }
        .ignoresSafeArea(edges: .all)
        .background(.white)
        
  
    }
    
}

#Preview {
    NavigationStack{
        SavedChoreographyView(choreo: SavedChoreo(name: "one Dance",items: [ ChoreoItem(assetName:"arms out"),
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
