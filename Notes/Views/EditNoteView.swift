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
    
    var body: some View {
        Form {
            Section {
                TextField("\(note.title!)", text:$title)
                    .onAppear{
                        title = note.title!
                        content = note.content!
                        
                    }
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
                    Button("Save") {
                        DataController().editNote(note: note, title: title, content: content, date: Date(), context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

