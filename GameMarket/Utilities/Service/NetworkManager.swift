//
//  NetworkManager.swift
//  GameMarket
//
//  Created by Okan Orkun on 3.06.2024.
//

import Foundation
import Network

final class NetworkManager: Weakifiable {
    
    static let shared = NetworkManager()

    private let monitor = NWPathMonitor()
    
    private init() {
        startMonitoring()
    }
    
    var isConnected: Bool {
        return isConnectedToWiFi
    }
    
    func request(endpoint: Endpoint) async throws -> Data {
        let request = try await endpoint.request()
        let session = URLSession.shared
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            
            return data
        } catch let urlError as URLError {
            throw NetworkError.urlError(urlError)
        } catch {
            throw error
        }
    }
    
    private var isConnectedToWiFi: Bool = false
    
    private func startMonitoring() {
        
        monitor.pathUpdateHandler = weakify { (self, path) in
            self.isConnectedToWiFi = path.status == .satisfied
        }
            
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}
