//
//  ProductModel.swift
//  haystekEcomLite
//
//  Created by Sandeep on 02/04/25.
//

import Foundation

struct ProductModel: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
    
    struct Rating: Codable {
        let rate: Double
        let count: Int
    }
}

struct FlashSaleItem {
    let product: ProductModel?
    let originalPrice: Double?
    let discountPrice: Double
    let timeRemaining: String
}
