//
//  NoteDetailView.swift
//  Notes
//
//  Created by Igor Bueno Franco on 12/08/23.
//

import SwiftUI

struct NoteDetailView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment (\.dismiss) var dismiss
    var note: FetchedResults<Note>.Element
    @State private var showingAlert = false
    
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        NavigationStack {
            Text(note.content ?? "No content available")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Spacer()
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            showingAlert = true
                        }) {
                            Image(systemName: "trash").foregroundColor(Color.red)
                        }.alert("Deseja relamente excluir a anotação?", isPresented: $showingAlert) {
                            Button("Cancelar", role: .cancel) {
                                showingAlert = false
                            }
                            Button("Excluir", role: .destructive) {
                                deleteNote()
                                dismiss()
                                showingAlert = false
                            }
                        }
                    }
                }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: EditNoteView(note: note)) {
                    Text("Editar")
                }
            }
        }
        .navigationBarTitle(note.title ?? "Untitled")

    }
    
    private func deleteNote() {
        withAnimation {
            managedObjContext.delete(note)
            dismiss()
            do {
                try managedObjContext.save()
                } catch {
                    print("Error deleting note: \(error)")
            }
            
        }
    }
}

