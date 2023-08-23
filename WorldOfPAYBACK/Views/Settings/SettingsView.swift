//
//  SettingsView.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 23.08.23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                #if DEBUG
                NavigationLink(destination: DebugView()) {
                    Text("Debug")
                }
                #endif
            }
            .navigationTitle(NSLocalizedString("settings",
                                               comment: ""))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
