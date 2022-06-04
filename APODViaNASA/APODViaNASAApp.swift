//
//  APODViaNASAApp.swift
//  APODViaNASA
//
//  Created by Shabi Naqvi on 04/06/22.
//

import SwiftUI

@main
struct APODViaNASAApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
