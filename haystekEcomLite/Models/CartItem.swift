//
//  CartItem.swift
//  haystekEcomLite
//
//  Created by Sandeep on 23/08/25.
//

import Foundation

struct CartItem {
    let product: MealCategory
    let id: String
    let name: String
    let price: Double
    let imageUrl: String
    var quantity: Int = 1
    var isSelected: Bool = true
}
