//
//  ViewController.swift
//  Apple Pie 2
//  Created by Sheree Edmund on 10/3/21.
//

import UIKit

class ViewController: UIViewController {
    
   
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
      }
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program", "code", "function", "run", "debugging"]
    var incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLoses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
            newRound()
        }
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
        
        
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Loses: \(totalLoses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLoses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
}
