//
//  ContentView.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 21.08.23.
//

import SwiftUI

struct MainView: View {    
    var body: some View {
        TabView {
            TransactionsView()
                .tabItem({
                    Label(NSLocalizedString("transactions",
                                            comment: ""),
                          systemImage: "list.bullet.rectangle.portrait")
                })
            SettingsView()
                .tabItem({
                    Label(NSLocalizedString("settings",
                                            comment: ""),
                          systemImage: "gear")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
