//
//  TitleText.swift
//  CreateWords
//
//  Created by Антон Макаров on 15.07.2022.
//

import SwiftUI

struct TitleText: View {
    @State var text : String

    var body: some View {
        Text(text)
            .padding()
            .font(.custom("AvenirNext-bold", size: 35))
            .cornerRadius(20)
            .frame(maxWidth: .infinity)
            .foregroundColor(.yellow)
            .background(Color("FirstPlayer")
            )
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(text: "Магнитотерапия")
    }
}
