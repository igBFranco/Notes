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
    
    @State private var selectedImage: UIImage?
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    
    @State private var isImagePickerPresented = false
    @State private var isCameraPresented = false
    
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
                Section(header: Text("Imagem")){
                    Button(action: {isCameraPresented.toggle()}){
                        HStack {
                            Image(systemName: "camera")
                            Text("Abrir Câmera")
                        }
                    }
                    Button(action: {isImagePickerPresented.toggle()}){
                        HStack {
                            Image(systemName: "photo.on.rectangle")
                            Text("Escolher Imagem")
                        }
                    }
                    if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                                .frame(height: 200)
                    }
                }
            }
            .navigationBarTitle("Adicionar Nota")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        DataController().addNote(title: title, content: content, date: date, imageData: selectedImage?.jpegData(compressionQuality: 0.8), context: managedObjContext)
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $isImagePickerPresented, onDismiss: loadImage) {
                ImagePicker(image: $selectedImage, sourceType: .photoLibrary)

            }
            .sheet(isPresented: $isCameraPresented, onDismiss: loadImage) {
                ImagePicker(image: $selectedImage, sourceType: .camera)

            }
        }
    }
    
    private func loadImage() {
        guard let selectedImage = selectedImage else { return }
    }
}

