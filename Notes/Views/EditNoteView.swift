//
//  EditNoteView.swift
//  Notes
//
//  Created by Igor Bueno Franco on 12/08/23.
//

import SwiftUI

struct EditNoteView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment (\.dismiss) var dismiss
    
    var note: FetchedResults<Note>.Element
    
    @State private var title = ""
    @State private var content = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Título")) {
                    TextField("", text: $title)
                    .onAppear{
                        title = note.title!
                        content = note.content!
                                                
                    }
                }
                Section(header: Text("Conteúdo")){
                    TextEditor(text: $content)
                }
                Section(header: Text("Data")){
                    DatePicker("", selection: $date,in: ...Date())
                }
            }
        }
        .navigationBarTitle("Editar Nota")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Salvar"){
                    DataController().editNote(note: note, title: title, content: content, date: Date(), context: managedObjContext)
                    dismiss()
                }
            }
        }
    }
}

