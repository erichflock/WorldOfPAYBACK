//
//  TransactionsViewModelTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Erich.Flock on 22.08.23.
//

import XCTest
@testable import WorldOfPAYBACK

final class TransactionsViewModelTests: XCTestCase {
    
    let items: [TransactionItem] = [.init(partnerDisplayName: "first item", alias: .init(reference: "1"), category: 1),
                                    .init(partnerDisplayName: "second item", alias: .init(reference: "2"), category: 1),
                                    .init(partnerDisplayName: "third item", alias: .init(reference: "3"), category: 2),
                                    .init(partnerDisplayName: "fourth item", alias: .init(reference: "4"), category: 2),
                                    .init(partnerDisplayName: "fifth item", alias: .init(reference: "5"), category: 2),
                                    .init(partnerDisplayName: "sixth item", alias: .init(reference: "6"), category: 3),
                                    .init(partnerDisplayName: "seventh item", alias: .init(reference: "7"), category: 4)]
    
    func test_searchedCategory_whenSearchedCategoryOne_filteredItemsShouldOnlyContainCategoryOne() {
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
    
    func test_filterItemsByCategory_whenSearchedCategoryTwo_filteredItemsShouldOnlyContainCategoryTwo() {
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
    
    func test_filterItemsByCategory_whenSearchedCategoryFour_filteredItemsShouldOnlyContainCategoryFour() {
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
    
    func test_filterItemsByCategory_whenSearchedCategoryTen_filteredItemsShouldBeEmpty() {
        let sut: TransactionsViewModel = .init(items: items)
        XCTAssertEqual(sut.filteredItems, sut.items, "precondition")
        
        sut.searchedCategory = "10"
        
        XCTAssertTrue(sut.filteredItems.isEmpty)
    }
    
    func test_filterItemsByCategory_whenSearchedCategoryString_filteredItemsShouldBeEmpty() {
        let sut: TransactionsViewModel = .init(items: items)
        XCTAssertEqual(sut.filteredItems, sut.items, "precondition")
        
        sut.searchedCategory = "Ten"
        
        XCTAssertTrue(sut.filteredItems.isEmpty)
    }
    
    func test_filterItemsByCategory_whenSearchedCategoryEmpty_filteredItemsShouldBeEqualItems() {
        let sut: TransactionsViewModel = .init(items: items)
        XCTAssertEqual(sut.filteredItems, sut.items, "precondition")
        
        sut.searchedCategory = ""
        
        XCTAssertEqual(sut.filteredItems, sut.items)
    }
    
}

extension TransactionItem: Equatable {
    
    public static func == (lhs: WorldOfPAYBACK.TransactionItem, rhs: WorldOfPAYBACK.TransactionItem) -> Bool {
        lhs.alias.reference == rhs.alias.reference
    }
    
}
