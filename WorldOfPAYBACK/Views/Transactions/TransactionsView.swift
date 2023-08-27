//
//  TransactionsView.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 21.08.23.
//

import SwiftUI

struct TransactionsView: View {
    
    @ObservedObject private var viewModel: TransactionsViewModel = .init()
    @StateObject var internetConnection = InternetConnection()
    
    var body: some View {
        NavigationView {
            List {
                if internetConnection.connected && !viewModel.isLoading {
                    sumView
                    ForEach(viewModel.filteredItems) { item in
                        NavigationLink(destination: TransactionDetailsView(partnerDisplayName: item.partnerDisplayName,
                                                                           description: item.transactionDetail.description)) {
                            TransactionsItemView(bookingDate: item.transactionDetail.bookingDate,
                                                 partnerDisplayName: item.partnerDisplayName,
                                                 description: item.transactionDetail.description,
                                                 reference: item.alias.reference,
                                                 amount: item.transactionDetail.value.amount,
                                                 currency: item.transactionDetail.value.currency)
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchedCategory,
                        prompt: Text(NSLocalizedString("category",
                                                       comment: "")))
            .keyboardType(.numberPad)
            .navigationTitle(NSLocalizedString("transactions",
                                               comment: ""))
            .overlay {
                if !internetConnection.connected {
                    VStack(alignment: .center, spacing: 10) {
                        Image(systemName: "icloud.slash")
                            .font(.system(size: 60))
                        Text(NSLocalizedString("error_internet", comment: ""))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .offset(y: -50)
                } else if viewModel.isLoading {
                    VStack {
                        Spacer()
                        ProgressView()
                            .controlSize(.large)
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            internetConnection.checkConnection()
            viewModel.task = Task {
                await viewModel.fetchTransactions()
            }
        }
        .onDisappear {
            viewModel.task?.cancel()
        }
        .onChange(of: internetConnection.connected) { connected in
            if connected {
                viewModel.task = Task {
                    await viewModel.fetchTransactions()
                }
            }
        }
        .alert(NSLocalizedString("error_fetch", comment: ""),
               isPresented: $viewModel.showErrorAlert) {
            Button(NSLocalizedString("ok", comment: ""),
                   role: .cancel) {
                viewModel.showErrorAlert = false
            }
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
