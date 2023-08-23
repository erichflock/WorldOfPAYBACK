//
//  NetworkConfig.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 21.08.23.
//

import SwiftUI

struct NetworkConfig {
    
    enum NetworkEnvironment: String, CaseIterable, Identifiable {
        case production
        case test
        case mock
        var id: Self { self }
    }
    
    struct URL {
        static let production = "https://api.payback.com/"
        static let test = "https://api-test.payback.com/"
        
        struct Path {
            static let transactions = "transactions"
        }
    }
    
    static var networkEnvironment: NetworkEnvironment = .production
    
}
