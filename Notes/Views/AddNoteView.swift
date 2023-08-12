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
        Form {
            Section {
                TextField("Note Title", text: $title)
                
                VStack {
                    TextEditor(text: $content)
                        .frame(height: 200)
                        .padding(.vertical, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.secondary, lineWidth: 1)
                        )
                }
                .padding()
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().addNote(title: title, content: content, date: date, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
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
