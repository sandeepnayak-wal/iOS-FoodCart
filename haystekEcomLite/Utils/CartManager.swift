//
//  CartManager.swift
//  haystekEcomLite
//
//  Created by Sandeep on 23/08/25.
//

class CartManager {
    static let shared = CartManager()
    private init() {}
    
    var cartItems: [CartItem] = []
    
    func addToCart(product: MealCategory) {
        let productId = String(product.idCategory)
        
        if let index = cartItems.firstIndex(where: { $0.id == productId }) {
            cartItems[index].quantity += 1
        } else {
            let newItem = CartItem(
                product: product, id: productId,
                name: product.strCategory,
                price: 200.00,
                imageUrl: product.strCategoryThumb
            )
            cartItems.append(newItem)
        }
    }
    
    func getCartItems() -> [CartItem] {
        return cartItems
    }
    
    func removeFromCart(product: MealCategory) {
        cartItems.removeAll { $0.product.idCategory == product.idCategory }
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
}
