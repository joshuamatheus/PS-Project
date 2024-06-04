//
//  GoogleBook.swift
//  MeuDiarioDeLeitura
//
//  Created by Joshua on 03/06/24.
//

import Foundation

struct GoogleBook: Codable, Identifiable {
    let id: String
    let title: String
    let authors: [String]?
    let pageCount: Int?
    let categories: [String]?
    let description: String?
    var coverImageURL: String? = " "

    enum VolumeInfoKeys: String, CodingKey {
        case volumeInfo
        case id
        case title
        case authors
        case description
        case pageCount
        case categories
        case imageLinks
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: VolumeInfoKeys.self)
        id = try container.decode(String.self, forKey: .id)
        let volumeInfoContainer = try container.nestedContainer(keyedBy: VolumeInfoKeys.self, forKey: .volumeInfo)
        title = try volumeInfoContainer.decode(String.self, forKey: .title)
        authors = try? volumeInfoContainer.decode([String].self, forKey: .authors)
        description = try? volumeInfoContainer.decode(String.self, forKey: .description)
        pageCount = try? volumeInfoContainer.decode(Int.self, forKey: .pageCount)
        categories = try? volumeInfoContainer.decode([String].self, forKey: .categories)
        let imageLinks = try? volumeInfoContainer.decodeIfPresent([String: String].self, forKey: .imageLinks)
        coverImageURL = modifyCoverImageURL(imageLinks?["thumbnail"])
    }

    func modifyCoverImageURL(_ url: String?) -> String? {
        guard var modifiedURL = url else { return nil }

        modifiedURL.insert("s", at: modifiedURL.index(modifiedURL.startIndex, offsetBy: 4))

        if let range = modifiedURL.range(of: "zoom=1") {
            modifiedURL.insert("0", at: range.upperBound)
        }

        return modifiedURL
    }
}

struct BooksResponse: Codable {
    let items: [GoogleBook]
}
