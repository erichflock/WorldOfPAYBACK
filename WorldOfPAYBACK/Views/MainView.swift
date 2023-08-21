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
                    Label("Transactions", systemImage: "list.bullet.rectangle.portrait")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
