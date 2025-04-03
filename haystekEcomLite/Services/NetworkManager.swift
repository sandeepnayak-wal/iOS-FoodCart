//
//  NetworkManager.swift
//  haystekEcomLite
//
//  Created by Sandeep on 02/04/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void)
}

import Foundation

class NetworkManager: NetworkServiceProtocol {
    static let shared = NetworkManager()
    private let baseURL = "https://fakestoreapi.com"
    
    func fetchProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/products") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        print("URL: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([ProductModel].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case noData
        case decodingError
        
        var localizedDescription: String {
            switch self {
            case .invalidURL: return "Invalid URL"
            case .invalidResponse: return "Invalid response from server"
            case .noData: return "No data received"
            case .decodingError: return "Failed to decode data"
            }
        }
    }
}
