//
//  NetworkConfig.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 21.08.23.
//

struct NetworkConfig {
    
    struct URL {
        static let production = "https://api.payback.com/"
        static let test = "https://api-test.payback.com/"
        
        struct Path {
            static let transactions = "transactions"
        }
    }
    
}
