//
//  GameViewModel.swift
//  CreateWords
//
//  Created by Антон Макаров on 17.07.2022.
//

import Foundation

class GameViewModel: ObservableObject {

    //MARK: - Published property
    @Published var player1: Player
    @Published var player2: Player
    @Published var wordsInGame = [String]()

    let baseWord: String
    var isFirst = true

    init(player1: Player, player2: Player, baseWord: String) {
        self.player1 = player1
        self.player2 = player2
        self.baseWord = baseWord.uppercased()
    }
    
//MARK: - Public func
    func validate(currentWord: String) -> Bool {
        let word = currentWord.uppercased()

        guard word != baseWord else {
            print("слово не может быть таким же как основное")
            return false
        }

        guard !(wordsInGame.contains(word)) else {
            print("Слово уже было названо")
            return false
        }

        guard word.count > 1 else {
            print("слишком короткое слово")
            return false
        }

        return true
    }

    func changeWordToChars(currentWord: String) -> [Character] {
        var charsArray = [Character]()
        for char in currentWord.uppercased() {
            charsArray.append(char)
        }
        return charsArray
    }

    func check(currentWord: String) -> Int {

        guard validate(currentWord: currentWord) else {
            return 0
        }

        var charsFromBaseWord = changeWordToChars(currentWord: baseWord)
        let charsFromCurrentWord = changeWordToChars(currentWord: currentWord)

        var resultWord = ""

        for char in charsFromCurrentWord {
            if charsFromBaseWord.contains(char) {
                resultWord.append(char)
                var indexChar = 0
                while charsFromBaseWord[indexChar] != char {
                    indexChar += 1
                }
                charsFromBaseWord.remove(at: indexChar)

            } else {
                print("из этих букв нельзя составить слово")
                return 0
            }
        }

        guard resultWord == currentWord.uppercased() else {
            print("слова не совпдают после логики проверки на совбадение букв")
            return 0
        }

        appendWordToGame(word: resultWord)
        addPointsToPlayer(count: resultWord.count)
        switchedPlayer()

        return resultWord.count
    }

// MARK: - Private func
    private func appendWordToGame(word: String) {
        wordsInGame.append(word)
    }

    private func switchedPlayer() {
        isFirst.toggle()
    }

    private func addPointsToPlayer(count: Int) {
        if isFirst {
            player1.score += count
        } else {
            player2.score += count
        }
    }
}

