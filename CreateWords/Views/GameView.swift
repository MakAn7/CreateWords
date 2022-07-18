//
//  GameView.swift
//  CreateWords
//
//  Created by Антон Макаров on 15.07.2022.
//

import SwiftUI

struct GameView: View {
    @State var word = ""
    @State var confermPresent = false
    @Environment(\.dismiss) var dismiss

    var viewModel: GameViewModel

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                Button(action: {
                    confermPresent.toggle()
                }, label: {
                    Text("Выход")
                        .font(.custom("AvenirNext-bold", size: 30))
                        .foregroundColor(.white)

                })
                    .padding(2)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(12)
                    .padding(.trailing, 10)
            }

            Text("\(viewModel.baseWord)")
                .padding(.horizontal, 10)
                .font(.custom("AvenirNext-bold", size: 40))

            HStack(alignment: .center, spacing: 20) {
                VStack {
                    Text("\(viewModel.player1.score)")
                    Text("\(viewModel.player1.name)")
                }

                .frame(width: screen.width / 2.2,
                       height: screen.width / 2.2)
                .background(Color("FirstPlayer"))
                .cornerRadius(12)
                .shadow(color: .red,
                        radius: 4,
                        x: 0,
                        y: 0)

                VStack {
                    Text("\(viewModel.player2.score)")
                    Text("\(viewModel.player2.name)")
                }
                .frame(width: screen.width / 2.2,
                       height: screen.width / 2.2)
                .background(Color("CurrentPlayer"))
                .cornerRadius(12)
                .shadow(color: .yellow,
                        radius: 4,
                        x: 0,
                        y: 0)
            }
            .font(.custom("AvenirNext-bold", size: 60))
            .foregroundColor(.white)
            .padding(.horizontal, 10)

            WordTextField(word: $word, placeholder: "Введите ваше слово ...")
                .cornerRadius(12)
                .padding(.horizontal, 10)

            Button(action: {
                let score = viewModel.check(currentWord: word)
                if score > 1 {
                    word = ""
                }
            }, label: {
                Text("Готово")
                    .foregroundColor(.white)
                    .font(.custom("AvenirNext-bold", size: 30))
                    .frame(maxWidth: .infinity)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(12)
                    .padding(.horizontal, 10)
            })

            List {

            }
            .listStyle(.plain)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Image("BGRedBlue"))
        .confirmationDialog(
            "Вы точно хотите завершить игру ?",
            isPresented: $confermPresent,
            titleVisibility: .visible,
            actions: {
                Button(role: .destructive,
                       action: {
                    self.dismiss()
                }, label: {
                    Text("Да")
                })
                Button(role: .cancel,
                       action: {
                }, label: {
                    Text("Нет")
                })
            })
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(
            player1: Player(name: "Вася"),
            player2: Player(name: "Федя"),
            baseWord: "Квадракоптер")
        )
    }
}
