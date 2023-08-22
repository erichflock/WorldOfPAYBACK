//
//  TransactionsViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 22.08.23.
//

import SwiftUI

final class TransactionsViewModel: ObservableObject {
    
    private(set) var items: [TransactionItem] = [] {
        didSet {
            filteredItems = items.sortByDate()
        }
    }
    
    @Published private(set) var filteredItems: [TransactionItem] = []
    
    @Published var searchedCategory: String = "" {
        didSet {
            filterItems(by: searchedCategory)
        }
    }
    
    init(items: [TransactionItem] = []) {
        let sortedItems = items.sortByDate()
        self.items = sortedItems
        self.filteredItems = sortedItems
    }
    
    func fetchTransactions() {
        do {
            let transactionItemsFromApi = try TransactionsAPI().getMockData()
            items = mapItems(from: transactionItemsFromApi?.items).sortByDate()
        } catch {
            //show alert
        }
    }
    
    private func filterItems(by category: String) {
        guard !searchedCategory.isEmpty else {
            filteredItems = items.sortByDate()
            return
        }
        guard let category = Int(searchedCategory) else {
            filteredItems.removeAll()
            return
        }
        filteredItems = items.filter { $0.category == category }.sortByDate()
    }
    
}

//MARK: Mapper Functions
extension TransactionsViewModel {
    
    private func mapItems(from itemsFromApi: [TransactionsApiModel.Item]?) -> [TransactionItem] {
        guard let itemsFromApi else { return [] }
        
        var items: [TransactionItem] = []
        
        for apiItem in itemsFromApi {
            if let partnerDisplayName = apiItem.partnerDisplayName, let reference = apiItem.alias?.reference, let bookingDate = apiItem.transactionDetail?.bookingDate, let amount = apiItem.transactionDetail?.value?.amount, let currency = apiItem.transactionDetail?.value?.currency {
                let item: TransactionItem = .init(partnerDisplayName: partnerDisplayName,
                                                  alias: .init(reference: reference),
                                                  category: apiItem.category,
                                                  transactionDetail: .init(description: apiItem.transactionDetail?.description,
                                                                           bookingDate: bookingDate,
                                                                           value: .init(amount: amount,
                                                                                        currency: map(apiCurrency: currency))))
                items.append(item)
            }
        }
        return items
    }
    
    private func map(apiCurrency: TransactionsApiModel.Item.TransactionDetail.Currency) -> TransactionItem.TransactionDetail.Currency {
        switch apiCurrency {
        case .PBP : return .PBP
        }
    }
}
