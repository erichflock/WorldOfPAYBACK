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
    var transactionDetail: TransactionDetail
    
    struct Alias {
        var reference: String
    }
    
    struct TransactionDetail {
        var description: String?
        var bookingDate: Date
        var value: Value
        
        struct Value {
            var amount: Int
            var currency: Currency
        }
        
        enum Currency: String {
            case PBP
            
            var name: String {
                rawValue
            }
        }
    }
}

extension Array where Element == TransactionItem {
    
    func sortByDate() -> [TransactionItem] {
        sorted(by: { $0.transactionDetail.bookingDate > $1.transactionDetail.bookingDate } )
    }
    
}
