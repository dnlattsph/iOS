//
//  DEVOTEApp.swift
//  DEVOTE
//
//  Created by D Naung Latt on 02/07/2021.
//

import SwiftUI

@main
struct DEVOTEApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
