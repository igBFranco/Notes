//
//  MapView.swift
//  Notes
//
//  Created by Igor Bueno Franco on 13/08/23.
//

import SwiftUI
import MapKit
import CoreLocationUI


struct MapView: View {
    @Binding var selectedLocation: CLLocationCoordinate2D?
    @Environment (\.dismiss) var dismiss
    var locationManager: CLLocationManager
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: .constant(MKCoordinateRegion(
                center: selectedLocation ?? locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )), showsUserLocation: true)
            .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                LocationButton {
                    if let location = locationManager.location {
                        selectedLocation = location.coordinate
                    } else {
                        selectedLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
                    }
                }
                .symbolVariant(.fill)
                .labelStyle(.titleAndIcon)
                .cornerRadius(20)
                .tint(.orange)
                Button("Salvar Localização") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
            }
        }
        .navigationBarTitle("Selecionar Localização")
    }
}





