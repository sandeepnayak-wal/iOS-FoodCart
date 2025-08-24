//
//  ImageLoader.swift
//  haystekEcomLite
//
//  Created by Sandeep on 23/08/25.
//

//import UIKit
//
//class ImageLoader {
//    static let shared = ImageLoader()
//    private let cache = NSCache<NSString, UIImage>()
//    
//    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
//        if let cachedImage = cache.object(forKey: urlString as NSString) {
//            completion(cachedImage)
//            return
//        }
//        
//        guard let url = URL(string: urlString) else {
//            completion(nil)
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            guard let data = data, error == nil, let image = UIImage(data: data) else {
//                completion(nil)
//                return
//            }
//            
//            self?.cache.setObject(image, forKey: urlString as NSString)
//            DispatchQueue.main.async {
//                completion(image)
//            }
//        }.resume()
//    }
//}
