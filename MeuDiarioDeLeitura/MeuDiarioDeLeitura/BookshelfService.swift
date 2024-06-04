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
            print("URL Invalida")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Erro ao buscar dados: \(error)")
                return
            }
            
            guard let data = data else {
                print("Sem dados")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(BooksResponse.self, from: data)
                DispatchQueue.main.async {
                    self.books = decodedResponse.items
                }
            } catch {
                print("Falha ao decodificar JSON: \(error)")
            }
        }
        
        task.resume()
    }
}
