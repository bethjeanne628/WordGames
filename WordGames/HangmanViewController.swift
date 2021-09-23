//
//  HangmanViewController.swift
//  WordGames
//
//  Created by Beth Silverstein
//

import UIKit

class HangmanViewController: UIViewController {
    
    // I'm hardcoding the hangman letters array as 6 letters because that's probably what I'm going to stick with for now, would like to change to different length words or even phrases in the future (which I know how to do, it won't be super difficult)
    var hangmanWord = ""
    var hangmanLetters = ["_", "_", "_", "_", "_", "_"] //this looks like it's unnecessary but it's actually useful for resetting purposes
    let blankAnswerLabel = "_ _ _ _ _ _"
    let blankHangmanLetters = ["_", "_", "_", "_", "_", "_"]
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var possibleLetterGuess: UILabel!
    @IBOutlet var keyboardLetters: [UIButton]!
    
    @IBOutlet weak var solutionButton: UIButton!
    @IBOutlet weak var guessButton: UIButton!
    
    @IBOutlet weak var hangmanCanvas: HangmanView!
    var currentGuessKeyboardButton: UIButton!
    
    
    
    
    @IBAction func endGameButtonPressed(_ sender: UIButton) {
        if guessButton.isEnabled {
            let alertController = UIAlertController(title: "Exit game?", message: "Would you like to exit the game? Your current game will be forfeit", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Never mind", style: .cancel, handler: nil)
            let forfeitAction = UIAlertAction(title: "Forfeit", style: .default, handler: { action in
                h_gamesForfeited += 1
                self.performSegue(withIdentifier: "hangmanEndSegue", sender: self)
            })
            alertController.addAction(cancelAction)
            alertController.addAction(forfeitAction)
            present(alertController, animated: true, completion: nil)
        }
        else {
            performSegue(withIdentifier: "hangmanEndSegue", sender: self)
        }
    }

    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        
        if solutionButton.isEnabled {
            let alertController = UIAlertController(title: "End current round?", message: "Are you sure you want to start a new round? You will forfeit the current round.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Never mind", style: .cancel, handler: nil)
            let cancelAction = UIAlertAction(title: "I'm sure!", style: .default, handler: {action in
                h_gamesForfeited += 1
                self.startNewGame()
            })
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        else {
            startNewGame()
        }
    }
    
    func startNewGame() {
        h_totalGamesPlayed += 1
        turnGameOnOrOff(state: true)
        answerLabel.text = blankAnswerLabel
        hangmanLetters = blankHangmanLetters
        currentGuessKeyboardButton = nil
        var newWord = wordbank.randomElement()
        while newWord == hangmanWord {
            newWord = wordbank.randomElement()
        }
        hangmanWord = newWord!
        hangmanCanvas.hangmanStage = 0
        hangmanCanvas.setNeedsDisplay()
    }
    
    
    @IBAction func keyboardButtonPressed(_ sender: UIButton) {
        possibleLetterGuess.text = sender.currentTitle
        currentGuessKeyboardButton = sender
    }
    
    
    @IBAction func guessButtonPressed(_ sender: UIButton) {
        if let guessLetter = possibleLetterGuess.text {
            h_numLettersGuessed += 1
            //the letter guessed is in the word
            if Character(guessLetter).isLetter && hangmanWord.contains(guessLetter){
                findLetterInAnswer(letter: guessLetter)
                var answerString = ""
                for printLetter in hangmanLetters {
                    answerString += "\(printLetter) "
                }
                answerString.removeLast() //gets rid of the last whitespace character
                answerLabel.text = answerString
                //if all letters have been found
                if checkIfAnswerComplete() {
                    h_gamesWon += 1
                    let alertController = UIAlertController(title: "You won!", message: "Congrats! The word was: \(hangmanWord)", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "Yay!", style: .default, handler: nil)
                    alertController.addAction(okayAction)
                    present(alertController, animated: true, completion: nil)
                    turnGameOnOrOff(state: false)
                }
            }
            //the letter guessed is not in the word
            else {
                if hangmanCanvas.hangmanStage < 7 {
                    hangmanCanvas.hangmanStage += 1
                    hangmanCanvas.setNeedsDisplay()
                    var message = ""
                    if hangmanCanvas.hangmanStage == 6 {
                        message = "\(guessLetter) is not in the word\nOnly 1 turn left!"
                    }
                    else {
                        message = "\(guessLetter) is not in the word"
                    }
                    let alertController = UIAlertController(title: "Incorrect guess", message: message, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "Okay", style: .default, handler: {action in
                        if self.hangmanCanvas.hangmanStage == 7 {
                            self.endGame()
                        }
                    })
                    alertController.addAction(okayAction)
                    present(alertController, animated: true, completion: nil)
                }
            }
            currentGuessKeyboardButton.isEnabled = false
        }
    }
    
    func endGame() {
        h_menHung += 1
        let alertController = UIAlertController(title: "Game Over", message: "You lost and now a man has been hanged", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Whoops", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
        showSolution()
        turnGameOnOrOff(state: false)
    }
    
    func findLetterInAnswer(letter: String) {
        var index = 0
        hangmanWord.forEach{hangmanLetter in
            if letter == String(hangmanLetter) {
                hangmanLetters[index] = String(hangmanLetter)
            }
            index += 1
        }
    }
    
    @IBAction func solutionButtonPressed(_ sender: UIButton) {
        let title = "Show Solution?"
        let message = "Are you sure you want to see the solution and forfeit the game?"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Never mind", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "Forfeit", style: .default, handler: {action in
            h_gamesForfeited += 1
            self.showSolution()
            self.turnGameOnOrOff(state: false)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func showSolution() {
        var index = 0
        self.hangmanWord.forEach{letter in
            self.hangmanLetters[index] = String(letter)
            index += 1
        }
        var answerString = ""
        for printLetter in self.hangmanLetters {
            answerString += "\(printLetter) "
        }
        answerString.removeLast() //gets rid of the last whitespace character
        self.answerLabel.text = answerString
    }
    
    func checkIfAnswerComplete() -> Bool {
        for letter in hangmanLetters {
            if !Character(letter).isLetter {
                return false
            }
        }
        return true
    }
    
    func turnGameOnOrOff(state: Bool) {
        if !state {
            possibleLetterGuess.text = "?"
        }
        solutionButton.isEnabled = state
        guessButton.isEnabled = state
        for button in keyboardLetters {
            button.isEnabled = state
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        possibleLetterGuess.layer.cornerRadius = possibleLetterGuess.frame.height * 0.5
        possibleLetterGuess?.layer.masksToBounds = true
        
        turnGameOnOrOff(state: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
