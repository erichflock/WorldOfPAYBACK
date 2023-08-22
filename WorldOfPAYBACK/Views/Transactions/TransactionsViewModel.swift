//
//  TransactionsViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 22.08.23.
//

import SwiftUI

final class TransactionsViewModel: ObservableObject {
    
    @Published private(set) var items: [TransactionItem] = []
    
    func fetchTransactions() {
        do {
            let transactionItemsFromApi = try TransactionsAPI().getMockData()
            items = mapItems(from: transactionItemsFromApi?.items)
        } catch {
            //show alert
        }
    }
    
}

//MARK: Mapper Functions
extension TransactionsViewModel {
    
    private func mapItems(from itemsFromApi: [TransactionsApiModel.Item]?) -> [TransactionItem] {
        guard let itemsFromApi else { return [] }
        
        var items: [TransactionItem] = []
        
        for apiItem in itemsFromApi {
            if let partnerDisplayName = apiItem.partnerDisplayName, let reference = apiItem.alias?.reference {
                let item: TransactionItem = .init(partnerDisplayName: partnerDisplayName,
                                                  alias: .init(reference: reference),
                                                  category: apiItem.category,
                                                  transactionDetail: .init(description: apiItem.transactionDetail?.description,
                                                                           bookingDate: apiItem.transactionDetail?.bookingDate,
                                                                           value: .init(amount: apiItem.transactionDetail?.value?.amount,
                                                                                        currency: map(apiCurrency: apiItem.transactionDetail?.value?.currency))))
                items.append(item)
            }
        }
        return items
    }
    
    private func map(apiCurrency: TransactionsApiModel.Item.TransactionDetail.Currency?) -> TransactionItem.TransactionDetail.Currency? {
        guard let apiCurrency else { return nil }
        switch apiCurrency {
        case .PBP : return .PBP
        }
    }
}
