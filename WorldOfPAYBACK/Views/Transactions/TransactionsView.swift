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
            List {
                ForEach(viewModel.items) { item in
                    TransactionsItemView(partnerName: item.partnerDisplayName,
                                         reference: item.alias.reference)
                }
            }
            .navigationTitle("Transactions")
        }
        .onAppear {
            viewModel.fetchTransactions()
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
