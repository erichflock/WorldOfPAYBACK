//
//  TransactionsAPI.swift
//  WorldOfPAYBACK
//
//  Created by Erich.Flock on 21.08.23.
//

import Foundation

enum TransactionsAPIError: Error {
    case invalidUrl
    case decodeError
}

final class TransactionsAPI {
    
    func getTransactions() async throws -> TransactionsApiModel? {
        var urlString = "\(NetworkConfig.URL.production)/\(NetworkConfig.URL.Path.transactions)"
#if DEBUG
        urlString = "\(NetworkConfig.URL.test)/\(NetworkConfig.URL.Path.transactions)"
#endif
        guard let url = URL(string: urlString) else { throw TransactionsAPIError.invalidUrl }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decode(data: data)
    }
    
    //TODO: Remove it when API is live
    func getMockData() throws -> TransactionsApiModel? {
        guard let url = Bundle.main.url(forResource: "PBTransactions", withExtension: "json") else { return nil }
        let data = try Data(contentsOf: url)
        return try decode(data: data)
    }
    
    private func decode(data: Data) throws -> TransactionsApiModel? {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let jsonData = try decoder.decode(TransactionsApiModel.self, from: data)
            return jsonData
        } catch {
            throw TransactionsAPIError.decodeError
        }
    }
    
}
