//
//  TransactionsItemView.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 22.08.23.
//

import SwiftUI

struct TransactionsItemView: View {
    
    let bookingDate: Date
    let partnerDisplayName: String
    let description: String?
    let reference: String
    let amount: Int
    let currency: TransactionItem.TransactionDetail.Currency
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .center) {
                    Text(partnerDisplayName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(reference)
                        .font(.caption)
                }
                if let description {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.primary)
                }
                Text(bookingDate.formatted())
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            Spacer()
            Text("\(amount) \(currency.name)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct TransactionsItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsItemView(bookingDate: .now, partnerDisplayName: "Rewe", description: "Description", reference: "795357452000810", amount: 100, currency: .PBP)
    }
}
