//
//  TransactionsView.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 21.08.23.
//

import SwiftUI

struct TransactionsView: View {
    
    @ObservedObject private var viewModel: TransactionsViewModel = .init()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    sumView
                    ForEach(viewModel.filteredItems) { item in
                        TransactionsItemView(partnerName: item.partnerDisplayName,
                                             reference: item.alias.reference, amount: item.transactionDetail.value.amount,
                                             currency: item.transactionDetail.value.currency)
                    }
                }
                .searchable(text: $viewModel.searchedCategory)
                .keyboardType(.numberPad)
                .navigationTitle("Transactions")
            }
        }
        .onAppear {
            viewModel.fetchTransactions()
        }
    }
    
    var sumView: some View {
        HStack {
            Text("")
            Spacer()
            Text("Sum: \(viewModel.getSumOfFilteredItems()) \(TransactionItem.TransactionDetail.Currency.PBP.name)")
                .font(.subheadline)
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
