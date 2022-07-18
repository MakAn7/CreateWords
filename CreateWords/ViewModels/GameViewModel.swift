//
//  GameViewModel.swift
//  CreateWords
//
//  Created by Антон Макаров on 17.07.2022.
//

import Foundation

enum WordError: Error {
    case identicalWord
    case smallWord
    case beforeWord
    case wrongWord
    case undefinedError
}

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
    func validate(currentWord: String) throws  {
        let word = currentWord.uppercased()

        guard word != baseWord else {
            throw WordError.identicalWord
        }

        guard !(wordsInGame.contains(word)) else {
            throw WordError.beforeWord
        }

        guard word.count > 1 else {
            throw WordError.smallWord
        }
        return
    }

    func changeWordToChars(currentWord: String) -> [Character] {
        var charsArray = [Character]()
        for char in currentWord.uppercased() {
            charsArray.append(char)
        }
        return charsArray
    }

    func check(currentWord: String) throws -> Int {
        do {
            try validate(currentWord: currentWord)
        } catch {
            throw error
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
                throw WordError.wrongWord
            }
        }

        guard resultWord == currentWord.uppercased() else {
            fatalError("Слова не совпдают после логики проверки на совпадение букв !")
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

