//
//  BookshelfService.swift
//  MeuDiarioDeLeitura
//
//  Created by Joshua on 31/05/24.
//

import Foundation

class BookshelfService: ObservableObject {

    @Published var books = [GoogleBook]()
    
    func fetchBooks(userId: String, shelfId: Int) {
        guard let url = URL(string: "https://www.googleapis.com/books/v1/users/\(userId)/bookshelves/\(shelfId)/volumes") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(BooksResponse.self, from: data)
                DispatchQueue.main.async {
                    for book in decodedResponse.items {
                        if let coverImageURL = book.coverImageURL {
                            print("Cover image URL: \(coverImageURL)")
                        } else {
                            print("No cover image URL found for book with ID: \(book.id)")
                        }
                        
                        if let categories = book.categories {
                            print("Categories: \(categories.joined(separator: ", "))")
                        } else {
                            print("No categories found for book with ID: \(book.id)")
                        }
                    }
                    self.books = decodedResponse.items
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }
        
        task.resume()
    }
}
