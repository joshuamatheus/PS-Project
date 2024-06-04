//
//  UpdateBookToWishList.swift
//  MeuDiarioDeLeitura
//
//  Created by Joshua on 03/06/24.
//

import SwiftUI

struct UpdateBookToWishList: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var book: Book
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Título", text: $book.title)
                TextField("Autor", text: $book.author)
            }
            .navigationTitle("Atualizar livro")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancelar"){
                        dismiss()
                    }
                }
            }
            
        }
    }
}
