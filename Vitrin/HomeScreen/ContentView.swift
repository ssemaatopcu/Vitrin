//
//  ContentView.swift
//  Vitrin
//
//  Created by Sema Topcu on 8/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var searchText = "" // Search text for filtering products
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return viewModel.products
        } else {
            return viewModel.products.filter { product in
                product.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView { ZStack {
            
    /*   Image("background_image")
             .resizable()
             .scaledToFill()
             .edgesIgnoringSafeArea(.all) */
            
            List(filteredProducts) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    
                    HStack {
                        URLImage(urlString: product.image)
                            .frame(width: 160, height: 160)
                            .clipped()
                        
                        VStack(alignment: .leading) {
                            
                            Text(product.title.split(separator: " ").prefix(4).joined(separator: " "))
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                            // .multilineTextAlignment(.center)
                            
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 5)
                    }
                    .frame(width: 280, height: 160)
                    .padding()
                    .background(Color.white)
                    .overlay(
                        
            // Border around each product item
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.orange, lineWidth: 1))
                    .padding(.bottom, 8)
                }
            }
            .navigationTitle("Products")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    SearchBar(text: $searchText)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("vitrin_app_logo")
                        .resizable()
                        .frame(width: 80, height: 50)
                }
            }
            .onAppear {
                viewModel.fetch() // Load the image data when the view appears
            }
        }
        }
    }
    
    
    struct SearchBar: View {
        @Binding var text: String // Binding to search text
        
        var body: some View {
            HStack {
                
                Image(systemName: "magnifyingglass") // Search icon
                    .foregroundColor(.gray)
                
                TextField("Search", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(8)
        }
    }
    
}
