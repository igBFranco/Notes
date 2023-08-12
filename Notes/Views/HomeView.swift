//
//  HomeView.swift
//  Notes
//
//  Created by Igor Bueno Franco on 12/08/23.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject var appLockVM: AppLockViewModel
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var note: FetchedResults<Note>
    
    @State private var showingAddView = false
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(note) { note in
                        NavigationLink(destination: NoteDetailView(note: note)) {
                            Text(note.title!)
                        }
                    }
                    .onDelete(perform: deleteNote)
                }
            }
            .navigationTitle("Anotações")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Note", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NotesConfigView().environmentObject(appLockVM)){
                        Image(systemName: "gear")
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
