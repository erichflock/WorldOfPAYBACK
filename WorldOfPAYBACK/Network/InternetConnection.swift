//
//  InternetConnection.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 23.08.23.
//

import SwiftUI
import Network

class InternetConnection: ObservableObject {
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.main //Dispatched on main queue since it will trigger the ui to update
    
    @Published private(set) var connected = true
    
    func checkConnection() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                    self?.connected = true
            } else {
                    self?.connected = false
            }
        }
        monitor.start(queue: queue)
    }
}
