//
//  ContentView.swift
//  CreateWords
//
//  Created by Антон Макаров on 15.07.2022.
//

import SwiftUI

struct StartView: View {
    @State var bigWord = ""
    @State var player1 = ""
    @State var player2 = ""

    var body: some View {
        VStack {
            TitleText(text: "Create Words !")

            WordTextField(word: $bigWord, placeholder: "Введите длинное слово")
                .cornerRadius(12)
                .padding(20)
                .padding(.top, 10)

            WordTextField(word: $player1, placeholder: "Игрок № 1")
                .cornerRadius(12)
                .padding(20)

           WordTextField(word: $player2, placeholder: "Игрок № 2")
                .cornerRadius(12)
                .padding(.horizontal,20)

            Button(action: {
                print("hello")
            }, label: {
                Text("Start")
                    .font(.custom("AvenirNext-bold", size: 30))
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 20)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(12)
                    .padding(.top, 20)
            })
            Spacer()
        }
        .background(Image("BGRedBlue"))
        .padding(.top,5)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
