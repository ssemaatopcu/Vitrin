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
    var body: some View {
        NavigationView {
            List(viewModel.products) { product in
                            NavigationLink(destination: ProductDetailView(product: product)) {
                                HStack {
                                    URLImage(urlString: product.image)
                                    VStack(alignment: .leading) {
                                        Text(product.title)
                                            .font(.headline)
                                        Text(product.description)
                                            .font(.subheadline)
                                            .lineLimit(2)
                                    }
                                }
                            }
                        }
                        .navigationTitle("Products")
                        .navigationBarItems(leading: Image("vitrin_app_logo").resizable().frame(width: 80, height: 50))
                        .onAppear {
                            viewModel.fetch()
                        }
                    }
                }
            }
