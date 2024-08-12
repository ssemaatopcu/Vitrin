//
//  ViewModel.swift
//  Vitrin
//
//  Created by Sema Topcu on 8/12/24.
//

import Foundation
import SwiftUI

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let category: String
    let description: String
    let image: String
}

class ViewModel: ObservableObject{
    
    @Published var products: [Product] = []
    
    func fetch() {
        guard let url = URL(string:"https://fakestoreapi.com/products")
        else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, _, error in
            guard let data = data, error == nil
            else {
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    self.products = products
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}
