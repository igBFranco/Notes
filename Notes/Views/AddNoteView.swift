//
//  AddNoteView.swift
//  Notes
//
//  Created by Igor Bueno Franco on 07/08/23.
//

import SwiftUI

struct AddNoteView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment (\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var content = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Título")) {
                    TextField("", text: $title)
                }
                Section(header: Text("Conteúdo")){
                    TextEditor(text: $content)
                }
                Section(header: Text("Data")){
                    DatePicker("", selection: $date,in: ...Date())
                }
            }
            .navigationBarTitle("Adicionar Nota")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        DataController().addNote(title: title, content: content, date: date, context: managedObjContext)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
