//
//  ViewController.swift
//  Apple Pie
//
//  Created by Luis Rodriguez on 3/5/24.
//

import UIKit

class ViewController: UIViewController {

    // Outlets for UI elements
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
   
    // Array of letter buttons
    @IBOutlet var letterButtons: [UIButton]!
    
    // Action triggered when a letter button is pressed
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        // Disabling the pressed button
        sender.isEnabled = false
        // Getting the letter from the button title
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        // Passing the guessed letter to the current game object
        currentGame.playerGuessed(letter: letter)
        // Updating the game state
        updateGameState()
    }
    
    // Array of words to guess
    var listOfWords = ["swift", "glorious", "incandescent", "bug", "program"]
    
    // Number of incorrect moves allowed
    let incorrectMovesAllowed = 7
    
    // Counters for total wins and losses
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    // Executed when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // Starting a new round
        newRound()
    }

    // Current game struct
    var currentGame: Game!

    // Function to start a new round
    func newRound() {
        if !listOfWords.isEmpty {
            // Removing the first word from the list and starting a new game with it
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            // Enabling letter buttons for the new round
            enableLetterButtons(true)
            // Updating the UI
            updateUI()
        } else {
            // Disabling letter buttons if there are no more words to guess
            enableLetterButtons(false)
        }
    }
    
    // Function to enable or disable letter buttons
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    // Function to update the UI elements
    func updateUI() {
        var letters = [String]()
        // Formatting the word with guessed letters
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        // Updating the score label
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        // Updating the hangman image based on incorrect moves remaining
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    // Function to update the game state
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            // Incrementing total losses if no moves remaining
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            // Incrementing total wins if the word is guessed correctly
            totalWins += 1
        } else {
            // Updating UI if the game is still in progress
            updateUI()
        }
    }

}
