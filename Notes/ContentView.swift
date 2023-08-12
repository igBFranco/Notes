//
//  ContentView.swift
//  Notes
//
//  Created by Igor Bueno Franco on 07/08/23.
//

import SwiftUI
import CoreData
import MapKit
import UIKit
import Combine

struct ContentView: View {
    @State private var showingAddNoteSheet = false
    @EnvironmentObject var appLockVM: AppLockViewModel
    var body: some View {
        ZStack{
            if !appLockVM.isAppLockEnabled || appLockVM.isAppUnlocked{
                HomeView().environmentObject(appLockVM)
            }
            else {
                NotesLockView().environmentObject(appLockVM)
            }
        }
        .onAppear{
            if appLockVM.isAppLockEnabled{
                appLockVM.appLockValidation()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
