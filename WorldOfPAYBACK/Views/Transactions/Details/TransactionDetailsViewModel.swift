//
//  TransactionDetailsViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 23.08.23.
//

import SwiftUI

final class TransactionDetailsViewModel: ObservableObject {
    
    let transactionDetails: TransactionItem.TransactionDetail
    
    init(transactionDetails: TransactionItem.TransactionDetail) {
        self.transactionDetails = transactionDetails
    }
    
}
