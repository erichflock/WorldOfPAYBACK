//
//  TransactionsItemView.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 22.08.23.
//

import SwiftUI

struct TransactionsItemView: View {
    
    let partnerName: String
    let reference: String
    let amount: Int
    let currency: TransactionItem.TransactionDetail.Currency
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(partnerName)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(reference)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("\(amount) \(currency.name)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .background(.white)
    }
}

struct TransactionsItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsItemView(partnerName: "REWE Group", reference: "795357452000810", amount: 100, currency: .PBP)
    }
}
