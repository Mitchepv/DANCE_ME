//
//  SavedChoreography.swift
//  Dance Me
//
//  Created by Nia Mitchell on 4/18/26.
//

import SwiftUI
import PhotosUI //added for photo

struct SavedChoreography: View {
    
    let vm: ChoreographyViewModel
    @State private var showEditSheet = false
    @State private var selectedChoreo: SavedChoreo?
    @State private var editedName = ""
    @State private var editingItems: [ChoreoItem] = []
    @State private var photoItem: PhotosPickerItem?
    
    var body: some View {
        VStack(spacing:16){
            List {
                if vm.savedChoreo.isEmpty {
                    Text("No saved choreographies yet")
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        
                }
                
                
                ForEach(vm.savedChoreo){ choreo in
                    HStack{
                        Text(choreo.name)
                            .font(.title)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role:.destructive){
                            delete(choreo)
                        }
                        
                        Button{
                            selectedChoreo = choreo
                            editedName = choreo.name
                            editingItems = choreo.items
                            showEditSheet = true
                            
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.green)
                    }
                    .background(
                        NavigationLink("", destination: SavedChoreographyView(choreo: choreo))
                            .opacity(0) )
                    
                }
                .sheet(isPresented: $showEditSheet){
                    
                    VStack{
                        Text("Edit Name")
                            .font(.title2)
                        
                        
                        TextField("Name", text: $editedName)
                                   .textFieldStyle(.roundedBorder)
                                   .padding()
                        
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                                
                                ForEach(editingItems.indices, id: \.self) { index in
                                    
                                    let item = editingItems[index]
                                    
                                    VStack {
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
                                    .onTapGesture {
                                        editingItems.remove(at: index)
                                    }
                                }
                            }
                        }
                        .frame(height: 150)
                        
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(vm.moves, id: \.self) { move in
                                    Image(move)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .onTapGesture {
                                            editingItems.append(ChoreoItem(assetName: move))
                                        }
                                }
                            }
                        }
                        
                        
                        PhotosPicker(selection: $photoItem, matching: .images) {
                            Label("Add Photo", systemImage: "photo")
                        }
                        .task(id: photoItem) {
                            if let item = photoItem,
                               let data = try? await item.loadTransferable(type: Data.self),
                               
                                let uiImage = UIImage(data: data) {
                                
                                editingItems.append(ChoreoItem(image: uiImage))
                            }
                            
                            photoItem = nil
                        }
                        
                        Spacer()
                        
                        Button("Save") {
                            if let selected = selectedChoreo,
                               let index = vm.savedChoreo.firstIndex(where: { $0.id == selected.id }) {
                                vm.savedChoreo[index] = SavedChoreo(
                                    id: selected.id,
                                    name: editedName,
                                    items: editingItems
                                )
                            }
                            resetEdit()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                        
                        
                        Button("Cancel") {
                            resetEdit()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                        
                        Spacer()
                        
                    }.padding()
                }
                
            }
            .navigationTitle("Saved Choreos")
            .listStyle(.plain)
            .padding(.horizontal)
                
            
          
        }
        .background(.purple.opacity(0.4))
        
     

        
    }
    
    private func delete(_ choreo: SavedChoreo) {
        if let index = vm.savedChoreo.firstIndex(where: { $0.id == choreo.id }) {
            vm.savedChoreo.remove(at: index)
        }
    }
    
    private func resetEdit() {
        showEditSheet = false
        selectedChoreo = nil
        editedName = ""
        editingItems = []
    }
}

#Preview {
    SavedChoreography(vm:ChoreographyViewModel())
}
