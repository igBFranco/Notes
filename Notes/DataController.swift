//
//  DataController.swift
//  Notes
//
//  Created by Igor Bueno Franco on 07/08/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "NoteModel")
    
    init() {
        container.loadPersistentStores{
            desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("Error")
        }
    }
    
    func addNote(title: String, content: String, date: Date, context: NSManagedObjectContext) {
        let note = Note(context: context)
        note.id = UUID()
        note.title = title
        note.content = content
        note.date = date
        
        save(context: context)
    }
    
    func editNote(note: Note, title: String, content: String, date: Date, context: NSManagedObjectContext) {
        note.title = title
        note.content = content
        note.date = date
        
        save(context: context)
    }
}
