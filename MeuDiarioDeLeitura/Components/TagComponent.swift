//
//  TagComponent.swift
//  MeuDiarioDeLeitura
//
//  Created by Joshua on 01/06/24.
//

import SwiftUI

struct TagComponent: View {
    var text: String
    var icon: String
    var backgroundColor: Color
    var textColor: Color
    
    var body: some View {
        HStack{
            Image(systemName: icon)
                .font(Font.custom("SF Pro", size: 12)
                    .weight(.medium))
                .foregroundStyle(textColor)
            Text(text)
                .font(Font.custom("SF Pro", size: 12)
                    .weight(.medium))
                .foregroundStyle(textColor)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
        .background(backgroundColor)
        .cornerRadius(6)
        
    }
}

#Preview {
    TagComponent(text: "Romance", icon: "heart.fill", backgroundColor: Color(red: 1, green: 0.18, blue: 0.33, opacity: 0.12), textColor: Color(red: 1, green: 0.18, blue: 0.33, opacity: 1))
}
