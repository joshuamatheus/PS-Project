//
//  GoogleBookDetailView.swift
//  MeuDiarioDeLeitura
//
//  Created by Joshua on 02/06/24.
//

import SwiftUI

import SwiftUI

struct GoogleBookDetailView: View {
    let book: GoogleBook

    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            if let url = URL(string: book.coverImageURL ?? " "),
               let imageData = try? Data(contentsOf: url),
               let uiImage = UIImage(data: imageData),
               let jpegData = uiImage.jpegData(compressionQuality: 0.8),
               let convertedImage = UIImage(data: jpegData) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 250, height: 350)
                    .background(
                        Image(uiImage: convertedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 250, height: 350)
                            .clipped()
                    )
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
            } else {
                Text("Falha ao carregar imagem da URL: \(book.coverImageURL ?? "Desconhecido")")
            }
            Text(book.title)
                .font(
                    Font.custom("SF Pro", size: 18)
                    .weight(.bold)
                )
                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
            if let authors = book.authors {
                Text(authors.joined(separator: ", "))
                    .font(
                        Font.custom("SF Pro", size: 16)
                        .weight(.regular))
                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.3))
                    .padding(.vertical, 2)
            }
            if let description = book.description {
                Text("Descrição\n\(description)")
                    .font(
                        Font.custom("SF Pro", size: 14)
                        .weight(.regular))
                    .padding(.horizontal)
            }
        }
    }
}

//#Preview {
//    GoogleBookDetailView(book: GoogleBook())
//}
