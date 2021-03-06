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
    @State var isAlertPresent = false
    @State var alertText = ""
    @Environment(\.dismiss) var dismiss
    
    var viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    confermPresent.toggle()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .padding()
                        .foregroundColor(.black)
                        .font(.headline)
                        .background(Color.red)
                        .clipShape(Circle())
                })
                    .padding(2)
                    .cornerRadius(12)
                    .padding(.leading, 15)
                Spacer()
            }
            
            Text("\(viewModel.baseWord)")
                .padding(.horizontal, 10)
                .font(.custom("AvenirNext-bold", size: 30))
                .background(LinearGradient(colors: [.red, .blue], startPoint: .topLeading, endPoint: .topTrailing)
                                .cornerRadius(12)
                )
            
            VStack(alignment: .center, spacing: 20) {
                HStack(alignment: .center, spacing: 20) {
                    Text("\(viewModel.player1.score)")
                    Text("\(viewModel.player1.name)")
                }
                .frame(maxWidth: .infinity)
                .background(Color("FirstPlayer"))
                .cornerRadius(12)
                .shadow(color: viewModel.isFirst ? .clear : .red,
                        radius: 10,
                        x: 0,
                        y: 0)
                
                HStack(alignment: .center, spacing: 20) {
                    Text("\(viewModel.player2.score)")
                    Text("\(viewModel.player2.name)")
                }
                .frame(maxWidth: .infinity)
                .background(Color("SecondPlayer"))
                .cornerRadius(12)
                .shadow(color: viewModel.isFirst ? .blue : .clear,
                        radius: 10,
                        x: 0,
                        y: 0)
            }
            .font(.custom("AvenirNext-bold", size: 30))
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            
            WordTextField(word: $word, placeholder: "Введите ваше слово ...")
                .cornerRadius(12)
                .padding(.horizontal, 10)
            
            Button(action: {
                var score = 0
                do {
                    try score = viewModel.check(currentWord: word)
                } catch WordError.identicalWord {
                    alertText = "Cлово не может быть таким же как основное ."
                    isAlertPresent.toggle()
                } catch WordError.smallWord {
                    alertText =  "Cлишком короткое слово"
                    isAlertPresent.toggle()
                } catch WordError.beforeWord {
                    alertText = "Слово уже было названо"
                    isAlertPresent.toggle()
                } catch WordError.wrongWord {
                    alertText = "Слово не может быть использовано в игре"
                    isAlertPresent.toggle()
                } catch {
                    alertText = "Не известная ошибка !"
                }
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
                    .padding(.horizontal, 30)
            })
            
            List {
                ForEach(0..<viewModel.wordsInGame.count,
                        id: \.description, content: {
                    WordCell(word: viewModel.wordsInGame[$0])
                        .background($0 % 2 == 0 ? Color("FirstPlayer") : Color("SecondPlayer"))
                        .listRowInsets(EdgeInsets())
                })
            }
            .listStyle(.plain)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(
            Image("BGRedBlue")
                .scaledToFill()
        )
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
        .alert(alertText,
               isPresented: $isAlertPresent,
               actions: {
            Text("Ok")
        })
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(
            player1: Player(name: "Васяzzzzzzzzzz"),
            player2: Player(name: "Федя"),
            baseWord: "Магнитотерапия")
        )
    }
}
