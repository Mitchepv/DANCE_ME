//
//  ChoreograohyView.swift
//  Dance Me
//
//  Created by Nia Mitchell on 4/16/26.
//

import SwiftUI
import SwiftData
import PhotosUI

struct ChoreographyView: View {
    
    let vm: ChoreographyViewModel
    @State private var name = ""
    @State private var photoSelection: PhotosPickerItem?
    @State private var showTextField = false
    let rows = [
        GridItem(.fixed(70)),
        GridItem(.fixed(70))
    ]
   
    
    var body: some View {
    
        VStack{
            
            Text("Create your own choreography")
                .font(.largeTitle)
                .foregroundStyle(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.purple.opacity(0.5))
            
            Spacer()
            
            ScrollView(.horizontal){
                LazyHGrid(rows:rows,spacing:5){
                    ForEach(vm.choreography.indices,id:\.self) { index in
                        let item = vm.choreography[index]
                        VStack{
                            if let image = item.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } else if let name = item.assetName {
                                Image(name)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .padding(4)
                        .background(.blue.opacity(0.2))
                        .cornerRadius(10)
                        .onTapGesture {
                            vm.removeMove(at: index)
                            
                        }
                    }
                }
            }
            Spacer()
            
            GroupBox{
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                        ForEach(vm.moves, id: \.self) { move in
                            Image(move)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .padding(4)
                                .background(.blue.opacity(0.2))
                                .cornerRadius(8)
                                .onTapGesture {
                                    vm.toggleMove(move)
                                }
                        }
                    }
                    
                }
                if !vm.choreography.isEmpty {
                    Text("Selected: \(vm.choreography.count)")
                }
            }
            .padding(.vertical)
            
            Spacer()
            
            if showTextField{
                TextField("Enter choreography name", text: $name)
                    .autocorrectionDisabled()
                    .submitLabel(.done)
                    .keyboardType(.asciiCapable)
                    .textFieldStyle(.roundedBorder)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    }
            }
            
            Button{
                if showTextField{
                    vm.saveChoreo(name: name)
                    name = ""
                }
                showTextField.toggle()
            }label: {
                Text(showTextField ? "Save" : "Save Choreography")
            }
            .font(.title2)
            .bold()
            .padding()
            .tint(.black)
            .background(.purple)
            .cornerRadius(10)
            

            
            Spacer()
            
            PhotosPicker(selection: $photoSelection, matching: .images,preferredItemEncoding:.automatic){
                Image(systemName: "photo")
                Text("Add your own images")
            }
            .font(.title2)
            .bold()
            .padding()
            .tint(.black)
            .background(.purple)
            .cornerRadius(10)
            .task(id: photoSelection) {
                await vm.addPhoto(from:photoSelection)
                photoSelection = nil
            }
            Spacer()
            Spacer()
        }
        .background(.gray.opacity(0.2))
        

        
    
    }
   
}

#Preview {
    ChoreographyView(vm: ChoreographyViewModel())
}
