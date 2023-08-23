//
//  TransactionsViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 22.08.23.
//

import SwiftUI

final class TransactionsViewModel: ObservableObject {
    
    private let transactionsApi: TransactionsAPIProtocol
    
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
    
    @Published var showErrorAlert = false
    
    init(items: [TransactionItem] = [], transactionsApi: TransactionsAPIProtocol = TransactionsAPI()) {
        let sortedItems = items.sortByDate()
        self.items = sortedItems
        self.filteredItems = sortedItems
        self.transactionsApi = transactionsApi
    }
    
    func fetchTransactions() async {
        switch NetworkConfig.networkEnvironment {
        case .production:
            do {
                let transactionItemsFromApi = try await transactionsApi.getTransactionsProd()
                handleItemsUpdate(transactionItemsFromApi)
            } catch {
                handleFetchError()
            }
        case .test:
            do {
                let transactionItemsFromApi = try await transactionsApi.getTransactionsTest()
                handleItemsUpdate(transactionItemsFromApi)
            } catch {
                handleFetchError()
            }
        case .mock:
            do {
                let transactionItemsFromApi = try transactionsApi.getMockData()
                handleItemsUpdate(transactionItemsFromApi)
            } catch {
                handleFetchError()
            }
        }
    }
    
    func getSumOfFilteredItems() -> Int {
        filteredItems.map( { $0.transactionDetail.value.amount } ).reduce(0, +)
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
    
    private func handleFetchError() {
        DispatchQueue.main.async { [weak self] in
            self?.items.removeAll()
            self?.showErrorAlert = true
        }
    }
    
    private func handleItemsUpdate(_ apiModel: TransactionsApiModel?) {
        guard let apiModel else {
            handleFetchError()
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.items = self?.mapItems(from: apiModel.items).sortByDate() ?? []
        }
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
