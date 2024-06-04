//
//  Book.swift
//  MeuDiarioDeLeitura
//
//  Created by Joshua on 31/05/24.
//


import SwiftData

@Model
class Book: Identifiable {
    @Attribute(.unique)
    var title: String
    var author: String
    

    init(title: String, author: String) {
        
        self.title = title
        self.author = author
    }
}
