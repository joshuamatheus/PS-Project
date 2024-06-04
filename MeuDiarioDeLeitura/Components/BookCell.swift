//
//  BookCell.swift
//  MeuDiarioDeLeitura
//
//  Created by Joshua on 03/06/24.
//

import SwiftUI

struct BookCell: View {
    let book: Book
    
    var body: some View {
        HStack{
            Text(book.title)
                .font(
                    Font.custom("SF Pro", size: 16)
                    .weight(.bold)
                )
                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
            Spacer()
            Text(book.author)
                .font(
                    Font.custom("SF Pro", size: 14)
                    .weight(.regular))
                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.3))
        }
    }
}

#Preview {
    BookCell(book: Book(title: "aaa", author: "aaaa"))
}
