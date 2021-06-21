//
//  SettingsView.swift
//  Fruits
//
//  Created by D Naung Latt on 15/06/2021.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isOnboarding") var isOnboarding: Bool = false 
    
    // MARK:  - BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators:false) {
                VStack {
                    //MARK: - SECTION 1
                    
                     GroupBox(
                        label:
                            SettingsLabelView(labelText: "Fruits", labelImage: "info.circle")
                     ) {
                        Divider().padding(.vertical, 4)
                        HStack(alignment: .center, spacing: 10)
                        {
                            Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:80, height:80)
                                    .cornerRadius(9.0)
                            
                            Text("Most frutis are naturally low in fat, sodium, and calories. None have cholesterol. Fruits are sources of many essentials, including potassium, dietary fiber, vitamins and much more.")
                                .font(.footnote)
                        }
                        
                     }
                    
                    //MARK: - SECTION 2
                    GroupBox(
                        label: SettingsLabelView(labelText: "Customization", labelImage: "paintbrush")
                        
                    ) {
                        Divider().padding(.vertical, 4)
                        Text("If you wish, you can restart the application by toggle the switch in this box. That way it starts the onboarding process and you will see the welcome screen again.")
                            .padding(.vertical, 8)
                            .frame(minHeight: 60)
                            .layoutPriority(1)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                        
                        Toggle(isOn: $isOnboarding) {
                            if isOnboarding {
                                
                                Text("Restarted".uppercased())
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color.green)
                                
                                
                            } else {
                                Text("Restart".uppercased())
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color.secondary)
                            }
                        }
                        .padding()
                        .background(
                            Color(UIColor.tertiarySystemBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        )
                        
                    }

                    //MARK: - SECTION 3
                    
                    GroupBox(label: SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")) {
                        
                        SettingsRowView(name: "Developer", content: "D Naung Latt")
                        SettingsRowView(name: "Designer", content: "Latt")
                        SettingsRowView(name: "Compatiblity", content: "iOS 14")
                        SettingsRowView(name: "Website", linkLabel: "SPH", linkDestination: "www.sph.com.sg")
                        SettingsRowView(name: "Twitter", linkLabel: "@SPH", linkDestination: "www.twitter.com/sph")
                        SettingsRowView(name: "Version", content: "1.1.0")
                        
                    } //: Box
                    
                    
                } //: VSTACK
                .navigationBarTitle(Text("Settings"), displayMode: .large)
                .navigationBarItems(trailing:
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark")
                        }
                )
                .padding()
                
            }//: SCROLL
            
        } //: NAVIGATION
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 11 Pro")
    }
}
