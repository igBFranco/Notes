//
//  NotesApp.swift
//  Notes
//
//  Created by Igor Bueno Franco on 07/08/23.
//

import SwiftUI

@main
struct NotesApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
