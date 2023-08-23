//
//  DebugView.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 23.08.23.
//

import SwiftUI

struct DebugView: View {
    
    @State var newtworkEnvironment: NetworkConfig.NetworkEnvironment = .production
    
    var body: some View {
        Form {
            Picker("Environment", selection: $newtworkEnvironment) {
                ForEach(NetworkConfig.NetworkEnvironment.allCases, id: \.self) {
                    Text($0.rawValue.capitalized)
                }
            }
            .pickerStyle(.inline)
        }
        .onChange(of: newtworkEnvironment) { _ in
            NetworkConfig.networkEnvironment = newtworkEnvironment
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
