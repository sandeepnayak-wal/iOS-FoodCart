//
//  CartManager.swift
//  haystekEcomLite
//
//  Created by Sandeep on 02/04/25.
//

class CartManager {
    static let shared = CartManager()
    private init() {}
    
    var cartItems: [CartItem] = []
    
    func addToCart(product: ProductModel) {
        let productId = String(product.id)
        
        if let index = cartItems.firstIndex(where: { $0.id == productId }) {
            cartItems[index].quantity += 1
        } else {
            let newItem = CartItem(
                product: product, id: productId,
                name: product.title,
                price: product.price,
                imageUrl: product.image
            )
            cartItems.append(newItem)
        }
    }
    
    func getCartItems() -> [CartItem] {
        return cartItems
    }
    
    func removeFromCart(product: ProductModel) {  
        cartItems.removeAll { $0.product.id == product.id }
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
}
