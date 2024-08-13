//
//  ContentView.swift
//  Vitrin
//
//  Created by Sema Topcu on 8/12/24.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 70)
                .background(Color.gray)
        }
        else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 70)
                .background(Color.gray)
                .onAppear {
                    fetchData()
                }
        }
    }
    private func fetchData() {
        guard let url = URL(string: urlString)
        else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
            data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var searchText = ""
    
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
        NavigationView {
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
                                
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1))
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
                        viewModel.fetch()
                    }
                }
            }
        }
    
    
    struct SearchBar: View {
        @Binding var text: String
        
        var body: some View {
            HStack {
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(8)
        }
    }

