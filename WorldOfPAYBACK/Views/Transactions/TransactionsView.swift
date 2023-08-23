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
                        NavigationLink(destination: TransactionDetailsView(partnerDisplayName: item.partnerDisplayName,
                                                                           description: item.transactionDetail.description)) {
                            TransactionsItemView(reference: item.alias.reference,
                                                 amount: item.transactionDetail.value.amount,
                                                 currency: item.transactionDetail.value.currency)
                        }
                    }
                }
                .searchable(text: $viewModel.searchedCategory,
                            prompt: Text(NSLocalizedString("category",
                                                           comment: "")))
                .keyboardType(.numberPad)
                .navigationTitle(NSLocalizedString("transactions",
                                                   comment: ""))
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
            Text("\(NSLocalizedString("sum", comment: "")): \(viewModel.getSumOfFilteredItems()) \(TransactionItem.TransactionDetail.Currency.PBP.name)")
                .font(.subheadline)
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
