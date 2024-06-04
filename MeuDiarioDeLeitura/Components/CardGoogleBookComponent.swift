//
//  CardGoogleBookComponent.swift
//  MeuDiarioDeLeitura
//
//  Created by Joshua on 03/06/24.
//

import SwiftUI

struct CardGoogleBookComponent: View {
    let book: GoogleBook
    
    var body: some View {
        HStack() {
            if let url = URL(string: book.coverImageURL ?? " "),
               let imageData = try? Data(contentsOf: url),
               let uiImage = UIImage(data: imageData),
               let jpegData = uiImage.jpegData(compressionQuality: 0.8),
               let convertedImage = UIImage(data: jpegData) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 156)
                    .background(
                        Image(uiImage: convertedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 156)
                            .clipped()
                    )
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
            } else {
                Text("Falha ao carregar imagem da URL: \(book.coverImageURL ?? "Descomhecido")")
            }
            VStack(alignment:.leading){
                if let authors = book.authors {
                    Text(authors.joined(separator: ", ").uppercased())
                        .font(
                            Font.custom("SF Pro", size: 11)
                            .weight(.semibold))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.3))
                        .padding(.vertical, 2)
                }
                Text(book.title)
                    .font(
                        Font.custom("SF Pro", size: 15)
                        .weight(.medium)
                    )
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                    .frame(width: 126, alignment: .topLeading)
                let genre = getGenreForCategory(categories: book.categories)
                let icon = getIconForCategory(categories: book.categories)
                let textColor = getTextColor(categories: book.categories)
                let backgroundColor = getBackgroundColor(categories: book.categories)
                Spacer()
                TagComponent(text: genre ?? "", icon: icon ?? "", backgroundColor: backgroundColor ?? Color(red: 0.2, green: 0.78, blue: 0.35, opacity: 0.12), textColor: textColor ?? Color(red: 0.2, green: 0.78, blue: 0.35, opacity: 0.12))
                    .padding(.vertical, 2)
            }
        }
        .padding()
        .frame(width:266, height: 180, alignment: .top)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    func getGenreForCategory(categories: [String]?) -> String?{
        guard let categories = categories else { return nil }
        let categoryString = categories.joined(separator: ", ")
        
        switch categoryString {
        case _ where categoryString.contains("Fiction"):
            return "Ficção"
        case _ where categoryString.contains("Adventure"):
            return "book"
        case _ where categoryString.contains("Science"):
            return "flask"
        case _ where categoryString.contains("Fantasy"):
            return "sparkles"
        case _ where categoryString.contains("Literary Criticism"):
            return "Romance"
        default:
            return "book.circle"
        }
    }
    
    func getIconForCategory(categories: [String]?) -> String? {
        guard let categories = categories else { return nil }
        let categoryString = categories.joined(separator: ", ")
        
        switch categoryString {
        case _ where categoryString.contains("Fiction"):
            return "book.closed.fill"
        case _ where categoryString.contains("Adventure"):
            return "book"
        case _ where categoryString.contains("Science"):
            return "flask"
        case _ where categoryString.contains("Fantasy"):
            return "sparkles"
        case _ where categoryString.contains("Literary Criticism"):
            return "heart.fill"
        default:
            return "book.circle"
        }
    }
    
    func getBackgroundColor(categories: [String]?) -> Color? {
        guard let categories = categories else { return nil }
        let categoryString = categories.joined(separator: ", ")
        
        switch categoryString {
        case _ where categoryString.contains("Fiction"):
            return Color(red: 1, green: 0.58, blue: 0).opacity(0.12)
        case _ where categoryString.contains("Adventure"):
            return Color(red: 0.35, green: 0.34, blue: 0.84).opacity(0.12)
        case _ where categoryString.contains("Science"):
            return Color(red: 1, green: 0.18, blue: 0.33).opacity(0.12)
        case _ where categoryString.contains("Fantasy"):
            return Color(red: 0, green: 0.48, blue: 1).opacity(0.12)
        case _ where categoryString.contains("Literary Criticism"):
            return Color(red: 1, green: 0.18, blue: 0.33).opacity(0.12)
        default:
            return Color(red: 0.64, green: 0.52, blue: 0.37).opacity(0.12)
        }
    }
    
    func getTextColor(categories: [String]?) -> Color? {
        guard let categories = categories else { return nil }
        let categoryString = categories.joined(separator: ", ")
        
        switch categoryString {
        case _ where categoryString.contains("Fiction"):
            return Color(red: 1, green: 0.58, blue: 0)
        case _ where categoryString.contains("Adventure"):
            return Color(red: 0.35, green: 0.34, blue: 0.84)
        case _ where categoryString.contains("Science"):
            return Color(red: 1, green: 0.18, blue: 0.33)
        case _ where categoryString.contains("Fantasy"):
            return Color(red: 0, green: 0.48, blue: 1)
        case _ where categoryString.contains("Literary Criticism"):
            return Color(red: 1, green: 0.18, blue: 0.33)
        default:
            return Color(red: 0.64, green: 0.52, blue: 0.37)
        }
    }
}

//#Preview {
//    CardGoogleBookComponent(book: <#GoogleBook#>, progress: <#Double#>)
//}
