//
//  ProductDetailView.swift
//  Vitrin
//
//  Created by Sema Topcu on 8/12/24.
//

import Foundation
import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                URLImage(urlString: product.image)
                    .frame(height: 300)
                
                Text(product.title)
                    .font(.largeTitle)
                    .padding(.top)
                
                Text("Price: $\(product.price, specifier: "%.2f")")
                    .font(.title2)
                    .padding(.vertical)
                
                Text(product.description)
                    .font(.body)
                
                // Add any additional information or images if available
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Product Details")
    }
}
