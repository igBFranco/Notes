//
//  NotesLockView.swift
//  Notes
//
//  Created by Igor Bueno Franco on 12/08/23.
//

import SwiftUI

import SwiftUI

struct NotesLockView: View {
    @EnvironmentObject var appLockVM: AppLockViewModel
    
    var body: some View {
        VStack(spacing: 30){
            Image(systemName: "lock")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("App Locked")
                .font(.title)
            Button("Open"){
                appLockVM.appLockValidation()
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 30)
            .padding(.vertical,15)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
        }
    }
}

struct NotesLockView_Previews: PreviewProvider {
    static var previews: some View {
        NotesLockView()
    }
}
