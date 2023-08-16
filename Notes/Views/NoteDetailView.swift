//
//  NoteDetailView.swift
//  Notes
//
//  Created by Igor Bueno Franco on 12/08/23.
//

import SwiftUI
import MapKit

struct NoteDetailView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment (\.dismiss) var dismiss
    var note: FetchedResults<Note>.Element
    @State private var showingAlert = false
    
    @State private var title = ""
    @State private var content = ""
    @State private var data = Date()
    @State private var latitude = Double()
    @State private var longitude = Double()

    
    var body: some View {
        NavigationStack {
            Text(note.content ?? "No content available")
            if let imageData = note.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 200)
            }
            VStack {
                if (note.latitude != 0 && note.longitude != 0) {
                    Map(coordinateRegion: .constant(MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: note.latitude, longitude: note.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
                    )), showsUserLocation: true)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding(20)
                }
                
                if let data = note.date {
                    Text(data.formatted())
                }
            }
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

