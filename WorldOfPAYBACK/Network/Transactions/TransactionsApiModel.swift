//
//  TransactionsApiModel.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 21.08.23.
//

import Foundation

struct TransactionsApiModel: Decodable {
    
    var items: [Item]?
    
    struct Item: Decodable {
        var partnerDisplayName: String?
        var alias: Alias?
        var category: Int?
        var transactionDetail: TransactionDetail?
        
        struct Alias: Decodable {
            var reference: String?
        }
        
        struct TransactionDetail: Decodable {
            var description: String?
            var bookingDate: Date?
            var value: Value?
            
            struct Value: Decodable {
                var amount: Int?
                var currency: Currency?
            }
            
            enum Currency: String, Decodable {
                case PBP
            }
        }
    }
    
}
