//
//  NetworkManager.swift
//  haystekEcomLite
//
//  Created by Sandeep on 23/08/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchMealCategories(completion: @escaping (Result<[MealCategory], Error>) -> Void)
}

class NetworkManager: NetworkServiceProtocol {
    static let shared = NetworkManager()
    private let baseURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
    
    func fetchMealCategories(completion: @escaping (Result<[MealCategory], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
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
                let decodedResponse = try JSONDecoder().decode(MealCategoryResponse.self, from: data)
                completion(.success(decodedResponse.categories))
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
