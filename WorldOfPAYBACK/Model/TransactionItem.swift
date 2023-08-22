//
//  TransactionItem.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 22.08.23.
//

import Foundation

struct TransactionItem: Identifiable {
    
    var id: String { alias.reference }
    var partnerDisplayName: String
    var alias: Alias
    var category: Int?
    var transactionDetail: TransactionDetail?
    
    struct Alias {
        var reference: String
    }
    
    struct TransactionDetail {
        var description: String?
        var bookingDate: Date?
        var value: Value?
        
        struct Value {
            var amount: Int?
            var currency: Currency?
        }
        
        enum Currency: String {
            case PBP
        }
    }
}
