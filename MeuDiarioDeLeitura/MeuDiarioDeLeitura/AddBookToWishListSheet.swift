//
//  AddBookToWishListSheet.swift
//  MeuDiarioDeLeitura
//
//  Created by Joshua on 03/06/24.
//

import SwiftUI

struct AddBookToWishListSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var author: String = ""
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Título", text: $title)
                TextField("Autor", text: $author)
            }
            .navigationTitle("Novo livro")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancelar"){
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing){
                    Button("Salvar"){
                        let book = Book(title: title, author: author)
                        context.insert(book)
                        dismiss()
                    }
                }
            }
            
        }
    }
}
