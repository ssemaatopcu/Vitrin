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
            VStack(alignment: .center) {
                
                URLImage(urlString: product.image)
                    .frame(height: 200)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                   // .cornerRadius(40)
                                    
                Text(product.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center) // Center the title
                    .padding(.top)
                    .padding(.horizontal)
                
                Divider()
                
                Text("Price: $\(product.price, specifier: "%.2f")")
                    .font(.title2)
                    .foregroundColor(.orange)
                    .padding(.vertical)
                
                Divider()
                
                Text(product.description)
                    .font(.body)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Product Details")
    }
}
