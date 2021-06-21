//
//  SettingsRowView.swift
//  Fruits
//
//  Created by D Naung Latt on 17/06/2021.
//

import SwiftUI

struct SettingsRowView: View {
    // MARK : PROPERTIES
    var name: String
    var content: String? = nil
    var linkLabel: String? = nil
    var linkDestination: String? = nil
    
    // MARK : BODY
    
    var body: some View {
        VStack {
            Divider().padding(.vertical, 4)
            HStack{
                Text(name).foregroundColor(Color.gray)
                Spacer()
                if (content != nil) {
                    Text(content!)
                } else if (linkLabel != nil && linkDestination != nil) {
                    Link(destination: URL(string: "https://\(linkDestination!)")!, label: {
                        Text(linkLabel!)
                    })
                    Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
                    
                }
                else {
                    EmptyView()
                }
            }
        }
    }
}


// MARK : PREVIEW

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsRowView(name: "Developer", content: "D Naung Latt")
                .previewLayout(.fixed(width: 375, height: 60))
                .padding()
            SettingsRowView(name: "Website", linkLabel: "SPH", linkDestination: "www.sph.com.sg")
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 375, height: 60))
                .padding()
        }
    }
}

