//
//  NotesConfigView.swift
//  Notes
//
//  Created by Igor Bueno Franco on 12/08/23.
//

import SwiftUI
import Combine

struct NotesConfigView:View {
    @EnvironmentObject var appLockVM:AppLockViewModel
    var body: some View{
            Form{
                Toggle(isOn: $appLockVM.isAppLockEnabled, label: {
                    Text("Bloqueio por Biometria")
                })
                .onChange(of: appLockVM.isAppLockEnabled, perform: { value in
                    appLockVM.appLockStateChange(appLockState: value)
                })
            }
            .navigationTitle("Configurações")
            .toolbar {
                NavigationLink(destination: VStack {
                    Text("Aplicativo criado utilizando SwiftUI, por Igor Bueno Franco como Trabalho de Conclusão de Curso de Engenharia de Software").padding(20).multilineTextAlignment(.center)
                    Text("Universidade do Contestado").padding(20).fontWeight(Font.Weight.bold)
                    Text("Campus Mafra - 2023")
                }.navigationTitle("Informações")
                ){
                    Image(systemName: "info.circle")
                    
                }
                
            }
        }
}
