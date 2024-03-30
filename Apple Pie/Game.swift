//
//  Game.swift
//  Apple Pie
//
//  Created by Luis Rodriguez on 3/6/24.
//

import Foundation

// Define a structure for a word guessing game
struct Game {
    var word: String // The word to be guessed
    var incorrectMovesRemaining: Int // Number of incorrect guesses allowed
    var guessedLetters: [Character] // Array to store guessed letters
    // Computed property to generate a string representing the word with guessed letters revealed
    var formattedWord: String {
        var guessedWord = "" // Initialize an empty string to store the guessed word
        // Iterate through each letter in the word
        for letter in word {
            // If the guessedLetters array contains the letter, append it to the guessedWord string
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                // If the guessedLetters array does not contain the letter, append "_" instead
                guessedWord += "_"
            }
        }
        // Return the final guessedWord string
        return guessedWord
    }

    // Method to handle when a player guesses a letter
    mutating func playerGuessed(letter: Character) {
        // Append the guessed letter to the guessedLetters array
        guessedLetters.append(letter)
        // If the word does not contain the guessed letter, decrement the incorrectMovesRemaining count
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}

