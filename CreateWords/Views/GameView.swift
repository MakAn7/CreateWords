//
//  GameView.swift
//  CreateWords
//
//  Created by Антон Макаров on 15.07.2022.
//

import SwiftUI

struct GameView: View {
    @State var word = ""

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                Button(action: {
                    print("go to StartView")
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

            Text("Синхрофазатрон")
                .padding(.horizontal, 10)
                .font(.custom("AvenirNext-bold", size: 40))

            HStack(alignment: .center, spacing: 20) {
                VStack {
                    Text("0")
                    Text("Вася")
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
                    Text("0")
                    Text("Петя")
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
                print("append current word")
                word = ""
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
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
