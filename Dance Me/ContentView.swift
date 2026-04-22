//
//  ContentView.swift
//  Dance Me
//
//  Created by Nia Mitchell on 4/15/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var vm = ChoreographyViewModel()
    
    
    var body: some View {
        NavigationStack{
            Text("Dance Me")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.purple)
            
            Spacer()
            
            Text("Create you own choerography")
                .font(.title)
                .bold()
                .foregroundStyle(.black)
            
            Image("DanceForMeIcon")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            NavigationLink{
                ChoreographyView(vm:vm)
            } label: {
                Text("Create Choreography")
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.purple)
                    .cornerRadius(10)
            }
         
            NavigationLink{
                SavedChoreography(vm:vm)
            } label: {
                Text("Saved Choreography")
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.purple)
                    .cornerRadius(10)
            }
            
          
        }
        
        Spacer()
    }
}

#Preview {
    ContentView()
}
