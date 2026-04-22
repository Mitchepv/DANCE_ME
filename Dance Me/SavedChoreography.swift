//
//  SavedChoreography.swift
//  Dance Me
//
//  Created by Nia Mitchell on 4/18/26.
//

import SwiftUI

struct SavedChoreography: View {
    
    let vm: ChoreographyViewModel
    @State private var showEditSheet = false
    @State private var selectedChoreo: SavedChoreo?
    @State private var editedName = ""
    
    var body: some View {
        List {
            if vm.savedChoreo.isEmpty {
                Text("No saved choreographies yet")
                    .foregroundColor(.gray)
            }
            
            ForEach(vm.savedChoreo){ choreo in
                HStack{
                    Text(choreo.name)
                        .font(.title)
                }
                .contentShape(Rectangle())
                .swipeActions(edge: .trailing) {
                    Button(role:.destructive){
                        delete(choreo)
                    }
                    
                    Button{
                        selectedChoreo = choreo
                        editedName = choreo.name
                        showEditSheet = true
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    .tint(.purple)
                }
                .background(
                    NavigationLink("", destination: SavedChoreographyView(choreo: choreo))
                        .opacity(0) )
                
            }
            .sheet(isPresented: $showEditSheet){
                Text("Edit Name")
                
                TextField("Name", text: $editedName)
                           .textFieldStyle(.roundedBorder)
                           .padding()
                
                Button("Save") {
                    if let selected = selectedChoreo,
                     let index = vm.savedChoreo.firstIndex(where: { $0.id == selected.id }) {
                        vm.savedChoreo[index].name = editedName
                    }
                    showEditSheet = false
                    selectedChoreo = nil
                }
                .buttonStyle(.borderedProminent)
                
                Button("Cancel") {
                    showEditSheet = false 
                    selectedChoreo = nil
                }
                
            }
            
        }
        .navigationTitle("Saved Choreos")
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
      }
}

#Preview {
    SavedChoreography(vm:ChoreographyViewModel())
}
