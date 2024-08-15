//
//  ViewModel.swift
//  Vitrin
//
//  Created by Sema Topcu on 8/12/24.
//

//import Foundation
import SwiftUI

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let category: String
    let description: String
    let image: String
}

class ViewModel: ObservableObject{
    
    @Published var products: [Product] = [] // List of products published to update the view
    
    // Fetches product data from the API and updates the products list
    func fetch() {
        guard let url = URL(string:"https://fakestoreapi.com/products")
        else {
            return
        }
        
        // A data task to fetch data from the API
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            // Check if data is valid and no error occurred
            guard let data = data, error == nil
            else {
                return
            }
            
            do {
                // Convert JSON data to an array of `Product` objects
                let products = try JSONDecoder().decode([Product].self, from: data)
                
                // Update the products list on the main thread
                DispatchQueue.main.async {
                    self.products = products
                }
            }
            catch {
                print(error)
            }
        }
        task.resume() // Start the data task
    }
}
