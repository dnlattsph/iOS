//
//  ContentView.swift
//  Africa
//
//  Created by D Naung Latt on 06/07/2021.
//

import SwiftUI

struct ContentView: View {
    // MARK: PROPERTIES
    let animals: [Animal] = Bundle.main.decode("animals.json")
    
    var body: some View {
        
        
        // MARK: BODY
        
        NavigationView {
            List {
                CoverImageView()
                    .frame(height:300)
                    .listRowInsets(EdgeInsets(top:0, leading:0, bottom: 0, trailing: 0))
                ForEach(animals) { animal in
                    NavigationLink(
                        destination: AnimalDetailView(animal: animal)) {
                            AnimalListItemView(animal: animal)
                        }
                }
            } // LIST
            
            .navigationBarTitle("Africa", displayMode: .large)
        } // NAVIGATION
        
        
    }
}

// MARK: PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
