//
//  URLImage.swift
//  Vitrin
//
//  Created by Sema Topcu on 8/13/24.
//

// import Foundation
import SwiftUI

// A view that displays an image from a URL
struct URLImage: View {
    let urlString: String
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            // If image data is available, display it
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 70)
                .background(Color.gray)
        }
        else {
            // Display a placeholder image while loading
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 70)
                .background(Color.gray)
                .onAppear {
                    fetchData() // Load the image data when the view appears
                }
        }
    }
    
    // Fetches image data from the URL
    private func fetchData() {
        guard let url = URL(string: urlString)
        else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
            data, _, _ in
            self.data = data // Store the fetched data
        }
        task.resume() // Start the data task
    }
}
