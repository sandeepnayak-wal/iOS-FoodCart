//
//  HomeViewModel.swift
//  haystekEcomLite
//
//  Created by Sandeep on 02/04/25.
//

import Foundation

class HomeViewModel {
    private let networkService: NetworkServiceProtocol
    var flashSaleItems: [FlashSaleItem] = []
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(networkService: NetworkServiceProtocol = NetworkManager.shared) {
        self.networkService = networkService
    }
    
    func fetchFlashSaleItems() {
        networkService.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.processProducts(products)
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func processProducts(_ products: [ProductModel]) {
        flashSaleItems = products.prefix(5).map { product in
            FlashSaleItem(
                product: product,
                originalPrice: product.price * 1.2,
                discountPrice: product.price,
                timeRemaining: "02:59:23"
            )
        }
        onDataUpdated?()
    }
}
