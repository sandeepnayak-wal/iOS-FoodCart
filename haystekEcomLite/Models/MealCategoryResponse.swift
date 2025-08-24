//
//  ProductModel.swift
//  haystekEcomLite
//
//  Created by Sandeep on 23/08/25.
//

import Foundation

struct MealCategoryResponse: Codable {
    let categories: [MealCategory]
}

struct MealCategory: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
    
}
