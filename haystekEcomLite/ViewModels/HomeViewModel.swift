//
//  HomeViewModel.swift
//  haystekEcomLite
//
//  Created by Sandeep on 23/08/25.
//

import Foundation

class HomeViewModel {
    private let networkService: NetworkServiceProtocol
    var mealCategories: [MealCategory] = []
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(networkService: NetworkServiceProtocol = NetworkManager.shared) {
        self.networkService = networkService
    }
    
    func fetchMealCategories() {
        networkService.fetchMealCategories { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self?.mealCategories = categories
                    self?.onDataUpdated?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
}
