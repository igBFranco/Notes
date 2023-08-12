//
//  ContentView.swift
//  Notes
//
//  Created by Igor Bueno Franco on 07/08/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var note: FetchedResults<Note>
    
    @State private var showingAddView = false
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(note) { note in
                        NavigationLink(destination: EditNoteView(note: note)) {
                            Text(note.title!)
                        }
                    }
                    .onDelete(perform: deleteNote)
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Note", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddNoteView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteNote(offsets: IndexSet) {
        withAnimation {
            offsets.map { note[$0] }.forEach(managedObjContext.delete)
            DataController().save(context: managedObjContext)
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
