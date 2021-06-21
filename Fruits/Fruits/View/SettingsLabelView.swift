//
//  SettingsLabelView.swift
//  Fruits
//
//  Created by D Naung Latt on 15/06/2021.
//

import SwiftUI

struct SettingsLabelView: View {
    // MARK: PROPERTIES
    
    var labelText: String
    var labelImage: String
    
    // MARK: BODY
    
    var body: some View {
        HStack {
            Text(labelText.uppercased()).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Spacer()
            Image(systemName: labelImage)
        }
    }
}

struct SettingsLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabelView(labelText: "Fruits", labelImage: "info.circle")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
