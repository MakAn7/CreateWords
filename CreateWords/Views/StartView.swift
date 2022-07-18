//
//  StartView.swift
//  CreateWords
//
//  Created by Антон Макаров on 15.07.2022.
//

import SwiftUI

struct StartView: View {
    @State var bigWord = ""
    @State var nameFirstPlayer = ""
    @State var nameSecondPlayer = ""
    @State var isAlertPresent = false
    @State var isShowedGame = false

    var body: some View {
        VStack {
            TitleText(text: "Create Words !")

            WordTextField(word: $bigWord, placeholder: "Введите длинное слово")
                .cornerRadius(12)
                .padding(20)
                .padding(.top, 10)

            WordTextField(word: $nameFirstPlayer, placeholder: "Игрок № 1")
                .cornerRadius(12)
                .padding(20)

           WordTextField(word: $nameSecondPlayer, placeholder: "Игрок № 2")
                .cornerRadius(12)
                .padding(.horizontal,20)

            Button(action: {
                if bigWord.count > 7 {
                    isShowedGame.toggle()
                } else {
                    isAlertPresent.toggle()
                }
            }, label: {
                Text("Старт")
                    .font(.custom("AvenirNext-bold", size: 25))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(12)
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
            })
            Spacer()
        }
        .background(Image("BGRedBlue"))
        .padding(.top,5)
        .alert("Слово короткое,введите не менее 8 букв .",
               isPresented: $isAlertPresent,
               actions: {
            Text("Ок")
        })
        .fullScreenCover(isPresented: $isShowedGame,
                         content: {
            let firstPlayerName = nameFirstPlayer == "" ? "Игрок №1" : nameFirstPlayer
            let secondPlayerName = nameSecondPlayer == "" ? "Игрок №2" : nameSecondPlayer

            let player1 = Player(name: firstPlayerName)
            let player2 = Player(name: secondPlayerName)
            
            let gameViewModel = GameViewModel(player1: player1, player2: player2, baseWord: bigWord)
            GameView(viewModel: gameViewModel)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
