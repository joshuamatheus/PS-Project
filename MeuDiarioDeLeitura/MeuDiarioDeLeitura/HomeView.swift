//
//  HomeView.swift
//  MeuDiarioDeLeitura
//
//  Created by Joshua on 31/05/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @State private var isShowingBookSheet = false
    @State private var bookToEdit: Book?
    @Query var books: [Book] = []
    
    @StateObject private var service = BookshelfService()
    
    @State private var searchText = ""
        
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading){
                    Text("Olá, Joshua!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    Text("O que você está lendo hoje?")
                        .font(.title2)
                        .padding(.top, 1)
                    HStack {
                        TextField("", text: $searchText)
                            .padding(7)
                            .padding(.horizontal, 25)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 8)
                                    
                                    if !searchText.isEmpty {
                                        Button(action: {
                                            self.searchText = ""
                                        }) {
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 8)
                                        }
                                    }
                                }
                            )
                    }
                }
                .padding(.horizontal)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading){
                        Text("Recomendações para você")
                            .font(
                                Font.custom("SF Pro", size: 20)
                                    .weight(.bold)
                            )
                            .padding(.top)
                            .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(service.books){googleBook in
                                    NavigationLink(destination: GoogleBookDetailView(book: googleBook)){
                                        CardGoogleBookComponent(book: googleBook)
                                                .padding(.horizontal, 5)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
                VStack(alignment:.leading, spacing: 8){
                    Text("Lista de desejo")
                        .font(
                            Font.custom("SF Pro", size: 20)
                                .weight(.bold)
                        )
                        .padding(.top)
                        .padding(.horizontal)
                    NavigationStack{
                        List{
                            ForEach(books.filter { searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText) }){book in
                                BookCell(book: book)
                                    .onTapGesture {
                                        bookToEdit = book
                                    }
                            }
                            .onDelete{IndexSet in
                                for index in IndexSet {
                                    context.delete(books[index])
                                }
                                
                            }
                        }
                    }
                    .sheet(isPresented: $isShowingBookSheet){
                        AddBookToWishListSheet()
                    }
                    .sheet(item: $bookToEdit){book in
                        UpdateBookToWishListSheet(book: book)
                    }
                    .toolbar{
                        if !books.isEmpty{
                            Button("Adicionar livro", systemImage: "plus"){
                                isShowingBookSheet = true
                            }
                        }
                    }
                    .overlay{
                        if books.isEmpty{
                            ContentUnavailableView(label: {
                                Label("Não há livros cadastrados", systemImage: "list.bullet.rectangle.portrait")
                            }, description: {
                                Text("Comece adicionando um livro para ver sua lista")
                            }, actions: {
                                Button("Adicionar livro"){
                                    isShowingBookSheet = true
                                }
                            })
                        }
                    }
                }
                
            }
       }
        .onAppear {
            service.fetchBooks(userId: "115757538151554187633", shelfId: 0)
        }
   }
}

//#Preview {
//    HomeView(text: "Search")
//}
