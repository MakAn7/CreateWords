//
//  WordCell.swift
//  CreateWords
//
//  Created by Антон Макаров on 19.07.2022.
//

import SwiftUI

struct WordCell: View {
    let word: String
    var body: some View {
        HStack {
            Text(word)
            Text("\(word.count)")
        }
        .foregroundColor(.white)
        .listRowSeparator(.hidden)
        .frame(maxWidth: . infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
        .font(.custom("AvenirNext-Bold", size: 22))
    }
}

struct WordCell_Previews: PreviewProvider {
    static var previews: some View {
        WordCell(word: "Магнит")
    }
}
