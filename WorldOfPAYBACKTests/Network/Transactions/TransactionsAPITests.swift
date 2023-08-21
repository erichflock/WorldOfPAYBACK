//
//  TransactionsAPITests.swift
//  WorldOfPAYBACKTests
//
//  Created by Erich.Flock on 21.08.23.
//

import XCTest
@testable import WorldOfPAYBACK

final class TransactionsAPITests: XCTestCase {
    
    private var sut: TransactionsAPI!
    
    override func setUpWithError() throws {
        sut = TransactionsAPI()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_transactionApiModel_whenJsonValid_shouldDecodeModelCorrectly() {
        do {
            let transactionApiModel = try getMockData()
            let firstItem = transactionApiModel?.items?.first
            XCTAssertEqual(transactionApiModel?.items?.count, 21)
            XCTAssertEqual(firstItem?.partnerDisplayName, "REWE Group")
            XCTAssertEqual(firstItem?.alias?.reference, "795357452000810")
            XCTAssertEqual(firstItem?.category, 1)
            XCTAssertEqual(firstItem?.transactionDetail?.description, "Punkte sammeln")
            XCTAssertEqual(firstItem?.transactionDetail?.bookingDate, getDateFrom(string: "2022-07-24T10:59:05+0200"))
            XCTAssertEqual(firstItem?.transactionDetail?.value?.amount, 124)
            XCTAssertEqual(firstItem?.transactionDetail?.value?.currency, .PBP)
        } catch {
            XCTFail("Fail to decode model")
        }
    }
    
}

//MARK: Helpers
extension TransactionsAPITests {
    
    private func getMockData() throws -> TransactionsApiModel? {
        guard let url = Bundle(for: Self.self).url(forResource: "PBTransactions", withExtension: "json") else { return nil }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let jsonData = try decoder.decode(TransactionsApiModel.self, from: data)
            return jsonData
        } catch {
            throw TransactionsAPIError.decodeError
        }
    }
    
    private func getDateFrom(string: String) -> Date {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: string)!
        return date
    }
    
}
