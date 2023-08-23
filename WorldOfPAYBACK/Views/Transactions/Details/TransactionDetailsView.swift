//
//  TransactionDetailsView.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 23.08.23.
//

import SwiftUI

struct TransactionDetailsView: View {
    
    @ObservedObject var viewModel: TransactionDetailsViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TransactionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailsView(viewModel: .init(transactionDetails: .init(bookingDate: .now, value: .init(amount: 0, currency: .PBP))))
    }
}
