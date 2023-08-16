//
//  AddNoteView.swift
//  Notes
//
//  Created by Igor Bueno Franco on 07/08/23.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct AddNoteView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment (\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var content = ""
    @State private var date = Date()
    
    @State private var selectedImage: UIImage?
    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    
    @State private var isImagePickerPresented = false
    @State private var isCameraPresented = false
    @State private var isMapPresented = false
    
    @State private var locationManager = CLLocationManager()
    
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
                    HStack {
                        Spacer()
                        DatePicker("", selection: $date, in: Date()...Date().addingTimeInterval(31536000))
                        .datePickerStyle(CompactDatePickerStyle())
                        .clipped()
                        .labelsHidden()
                        Spacer()
                    }
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
                Section(header: Text("Localização")){
                    if (latitude != 0 && longitude != 0) {
                        Map(coordinateRegion: .constant(MKCoordinateRegion(center: selectedLocation ?? locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))), showsUserLocation: true)
                    .frame(height: 200)
                    .cornerRadius(10)
                    }
                    Button(action: {isMapPresented.toggle()}){
                        HStack {
                            Image(systemName: "location.fill")
                            Text("Selecione a Localização")
                        }
                    }
                }

            }
            .navigationBarTitle("Adicionar Nota")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        DataController().addNote(title: title, content: content, date: date, imageData: selectedImage?.jpegData(compressionQuality: 0.8), latitude: selectedLocation?.latitude ?? 0, longitude: selectedLocation?.longitude ?? 0 , context: managedObjContext)
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
            .sheet(isPresented: $isMapPresented, onDismiss: updateSelectedLocation) {
                MapView(selectedLocation: $selectedLocation, locationManager: locationManager)
            }

        }
    }
    
    private func loadImage() {
        guard let selectedImage = selectedImage else { return }
    }
    
    private func updateSelectedLocation() {
        if let location = selectedLocation {
               latitude = location.latitude
               longitude = location.longitude
           }
    }
}

