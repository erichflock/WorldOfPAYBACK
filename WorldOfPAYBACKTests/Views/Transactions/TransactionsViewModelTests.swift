//
//  TransactionsViewModelTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Erich.Flock on 22.08.23.
//

import XCTest
@testable import WorldOfPAYBACK

final class TransactionsViewModelTests: XCTestCase {
    
    override func tearDownWithError() throws {
        NetworkConfig.networkEnvironment = .production
    }
    
    let items: [TransactionItem] = [.init(partnerDisplayName: "first item", alias: .init(reference: "0"), category: 1, transactionDetail: .init(bookingDate: .now.advanced(by: -6), value: .init(amount: 1, currency: .PBP))),
                                    .init(partnerDisplayName: "second item", alias: .init(reference: "1"), category: 1, transactionDetail: .init(bookingDate: .now.advanced(by: -5), value: .init(amount: 2, currency: .PBP))),
                                    .init(partnerDisplayName: "third item", alias: .init(reference: "2"), category: 2, transactionDetail: .init(bookingDate: .now.advanced(by: -4), value: .init(amount: 3, currency: .PBP))),
                                    .init(partnerDisplayName: "fourth item", alias: .init(reference: "3"), category: 2, transactionDetail: .init(bookingDate: .now.advanced(by: -3), value: .init(amount: 4, currency: .PBP))),
                                    .init(partnerDisplayName: "fifth item", alias: .init(reference: "4"), category: 2, transactionDetail: .init(bookingDate: .now.advanced(by: -2), value: .init(amount: 5, currency: .PBP))),
                                    .init(partnerDisplayName: "sixth item", alias: .init(reference: "5"), category: 3, transactionDetail: .init(bookingDate: .now.advanced(by: -1), value: .init(amount: 6, currency: .PBP))),
                                    .init(partnerDisplayName: "seventh item", alias: .init(reference: "6"), category: 4, transactionDetail: .init(bookingDate: .now.advanced(by: 0), value: .init(amount: 7, currency: .PBP)))]
    
    func test_filteredItems_whenSearchedCategoryOne_shouldOnlyContainCategoryOne() {
        let sut: TransactionsViewModel = .init(items: items)
        XCTAssertEqual(sut.filteredItems, sut.items, "precondition")
        
        sut.searchedCategory = "1"
        
        XCTAssertNotEqual(sut.filteredItems, sut.items)
        for filteredItem in sut.filteredItems {
            if filteredItem.category != 1 {
                XCTFail("Filtered items should only contain category one, but other categories were found")
            }
        }
    }
    
    func test_filteredItems_whenSearchedCategoryTwo_shouldOnlyContainCategoryTwo() {
        let sut: TransactionsViewModel = .init(items: items)
        XCTAssertEqual(sut.filteredItems, sut.items, "precondition")
        
        sut.searchedCategory = "2"
        
        XCTAssertNotEqual(sut.filteredItems, sut.items)
        for filteredItem in sut.filteredItems {
            if filteredItem.category != 2 {
                XCTFail("Filtered items should only contain category two, but other categories were found")
            }
        }
    }
    
    func test_filteredItems_whenSearchedCategoryFour_shouldOnlyContainCategoryFour() {
        let sut: TransactionsViewModel = .init(items: items)
        XCTAssertEqual(sut.filteredItems, sut.items, "precondition")
        
        sut.searchedCategory = "4"
        
        XCTAssertNotEqual(sut.filteredItems, sut.items)
        for filteredItem in sut.filteredItems {
            if filteredItem.category != 4 {
                XCTFail("Filtered items should only contain category four, but other categories were found")
            }
        }
    }
    
    func test_filteredItems_whenSearchedCategoryTen_shouldBeEmpty() {
        let sut: TransactionsViewModel = .init(items: items)
        XCTAssertEqual(sut.filteredItems, sut.items, "precondition")
        
        sut.searchedCategory = "10"
        
        XCTAssertTrue(sut.filteredItems.isEmpty)
    }
    
    func test_filteredItems_whenSearchedCategoryString_shouldBeEmpty() {
        let sut: TransactionsViewModel = .init(items: items)
        XCTAssertEqual(sut.filteredItems, sut.items, "precondition")
        
        sut.searchedCategory = "Ten"
        
        XCTAssertTrue(sut.filteredItems.isEmpty)
    }
    
    func test_filteredItems_whenSearchedCategoryEmpty_shouldBeEqualItems() {
        let sut: TransactionsViewModel = .init(items: items)
        XCTAssertEqual(sut.filteredItems, sut.items, "precondition")
        
        sut.searchedCategory = ""
        
        XCTAssertEqual(sut.filteredItems, sut.items)
    }
    
    func test_filteredItems_shouldBeSortedFromNewestToOldest() {
        let sut: TransactionsViewModel = .init(items: items)
        
        XCTAssertEqual(sut.filteredItems[0], items[6])
        XCTAssertEqual(sut.filteredItems[1], items[5])
        XCTAssertEqual(sut.filteredItems[2], items[4])
        XCTAssertEqual(sut.filteredItems[3], items[3])
        XCTAssertEqual(sut.filteredItems[4], items[2])
        XCTAssertEqual(sut.filteredItems[5], items[1])
        XCTAssertEqual(sut.filteredItems[6], items[0])
    }
    
    func test_filteredItems_whenSearchedCategoryTwo_shouldBeSortedFromNewestToOldest() {
        let sut: TransactionsViewModel = .init(items: items)
        XCTAssertEqual(sut.filteredItems, sut.items, "precondition")
        
        sut.searchedCategory = "2"
        
        XCTAssertEqual(sut.filteredItems.count, 3)
        XCTAssertEqual(sut.filteredItems[0], items[4])
        XCTAssertEqual(sut.filteredItems[1], items[3])
        XCTAssertEqual(sut.filteredItems[2], items[2])
    }
    
    func test_getSumOfFilteredItems_whenNoCategory_shouldReturnSumOfAllItems() {
        let sut: TransactionsViewModel = .init(items: items)
        
        sut.searchedCategory = ""
        
        XCTAssertEqual(sut.getSumOfFilteredItems(), 28)
    }
    
    func test_getSumOfFilteredItems_whenCategoryOne_shouldReturnSumOfAllItemsOfCategoryOne() {
        let sut: TransactionsViewModel = .init(items: items)
        
        sut.searchedCategory = "1"
        
        XCTAssertEqual(sut.getSumOfFilteredItems(), 3)
    }
    
    func test_getSumOfFilteredItems_whenCategoryTwo_shouldReturnSumOfAllItemsOfCategoryTwo() {
        let sut: TransactionsViewModel = .init(items: items)
        
        sut.searchedCategory = "2"
        
        XCTAssertEqual(sut.getSumOfFilteredItems(), 12)
    }
    
    func test_fetchTransactions_whenProductionEnvironment_shouldCallGetTransactionsProd() async {
        NetworkConfig.networkEnvironment = .production
        let transactionsApiSpy = TransactionsApiSpy()
        let sut: TransactionsViewModel = .init(transactionsApi: transactionsApiSpy)
        XCTAssertEqual(NetworkConfig.networkEnvironment, .production)
        XCTAssertEqual(transactionsApiSpy.getTransactionsProdCallCount, 0, "preconditon")
        XCTAssertEqual(transactionsApiSpy.getTransactionsTestCallCount, 0, "preconditon")
        XCTAssertEqual(transactionsApiSpy.getMockDataCallCount, 0, "preconditon")
        
        let task = Task {
            await sut.fetchTransactions()
        }
        
        await task.value
        XCTAssertEqual(transactionsApiSpy.getTransactionsProdCallCount, 1)
        XCTAssertEqual(transactionsApiSpy.getTransactionsTestCallCount, 0)
        XCTAssertEqual(transactionsApiSpy.getMockDataCallCount, 0)
    }
    
    func test_fetchTransactions_whenTestEnvironment_shouldCallGetTransactionsTest() async {
        NetworkConfig.networkEnvironment = .test
        let transactionsApiSpy = TransactionsApiSpy()
        let sut: TransactionsViewModel = .init(transactionsApi: transactionsApiSpy)
        XCTAssertEqual(NetworkConfig.networkEnvironment, .test)
        XCTAssertEqual(transactionsApiSpy.getTransactionsProdCallCount, 0, "preconditon")
        XCTAssertEqual(transactionsApiSpy.getTransactionsTestCallCount, 0, "preconditon")
        XCTAssertEqual(transactionsApiSpy.getMockDataCallCount, 0, "preconditon")
        
        let task = Task {
            await sut.fetchTransactions()
        }
        
        await task.value
        XCTAssertEqual(transactionsApiSpy.getTransactionsProdCallCount, 0)
        XCTAssertEqual(transactionsApiSpy.getTransactionsTestCallCount, 1)
        XCTAssertEqual(transactionsApiSpy.getMockDataCallCount, 0)
    }
    
    func test_fetchTransactions_whenMockEnvironment_shouldCallGetMockData() async {
        NetworkConfig.networkEnvironment = .mock
        let transactionsApiSpy = TransactionsApiSpy()
        let sut: TransactionsViewModel = .init(transactionsApi: transactionsApiSpy)
        XCTAssertEqual(NetworkConfig.networkEnvironment, .mock)
        XCTAssertEqual(transactionsApiSpy.getTransactionsProdCallCount, 0, "preconditon")
        XCTAssertEqual(transactionsApiSpy.getTransactionsTestCallCount, 0, "preconditon")
        XCTAssertEqual(transactionsApiSpy.getMockDataCallCount, 0, "preconditon")
        
        let task = Task {
            await sut.fetchTransactions()
        }
        
        await task.value
        XCTAssertEqual(transactionsApiSpy.getTransactionsProdCallCount, 0)
        XCTAssertEqual(transactionsApiSpy.getTransactionsTestCallCount, 0)
        XCTAssertEqual(transactionsApiSpy.getMockDataCallCount, 1)
    }
    
}

extension TransactionItem: Equatable {
    
    public static func == (lhs: WorldOfPAYBACK.TransactionItem, rhs: WorldOfPAYBACK.TransactionItem) -> Bool {
        lhs.alias.reference == rhs.alias.reference
    }
    
}

private class TransactionsApiSpy: TransactionsAPIProtocol {
    
    private(set) var getTransactionsProdCallCount = 0
    private(set) var getTransactionsTestCallCount = 0
    private(set) var getMockDataCallCount = 0
    
    func getTransactionsProd() async throws -> WorldOfPAYBACK.TransactionsApiModel? {
        getTransactionsProdCallCount += 1
        return nil
    }
    
    func getTransactionsTest() async throws -> WorldOfPAYBACK.TransactionsApiModel? {
        getTransactionsTestCallCount += 1
        return nil
    }
    
    func getMockData() throws -> WorldOfPAYBACK.TransactionsApiModel? {
        getMockDataCallCount += 1
        return nil
    }
    
}
