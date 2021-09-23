//
//  JumbleViewController.swift
//  WordGames
//
//  Created by Beth Silverstein
//

import UIKit


//this is temporary for this project because I am extremely picky about what words are good for word jumbles, they can't just be any 6-letter word
let wordbank = ["INJURE", "STANZA", "UNTOLD", "PLURAL", "GOVERN", "WEASEL", "FLAUNT", "BOOGIE", "OPPOSE", "GATHER", "GOPHER", "INVITE", "WINNER", "FLOPPY", "TARGET", "SUBURB", "SPRING", "ALWAYS", "BORDER", "MEDICS", "SUNDRY", "PLACES", "FORMAL", "ZOMBIE", "BUTTER", "CLOSED", "DECIDE", "WINTER", "AUTUMN", "SUMMER", "CURBED", "SEWING", "BOXING", "ZIPPER"];

class JumbleViewController: UIViewController {
    
    let squarePlaceholder = "___"
    var currentWord = ""
    var shuffledWord = ""
    
    
    @IBOutlet var solvingSquares: [UILabel]!
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBOutlet weak var jumbleButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    
    @IBAction func endGameButtonPressed(_ sender: UIButton) {
        if jumbleButton.isEnabled {
            let alertController = UIAlertController(title: "Exit game?", message: "Would you like to exit the game? Your current game will be forfeit", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Never mind", style: .cancel, handler: nil)
            let forfeitAction = UIAlertAction(title: "Forfeit", style: .default, handler: { action in
                j_forfeited += 1
                self.performSegue(withIdentifier: "jumbleEndSegue", sender: self)
            })
            alertController.addAction(cancelAction)
            alertController.addAction(forfeitAction)
            present(alertController, animated: true, completion: nil)
        }
        else {
            performSegue(withIdentifier: "jumbleEndSegue", sender: self)
        }
    }
 
    @IBAction func letterButtonPressed(_ sender: UIButton) {
                
        if let title = sender.currentTitle {
            let place = findNextEmpty()
            if place >= 0 {
                solvingSquares[place].text = title
                sender.isEnabled = false
            }
        }
    }
    
    //returns -1 if there's no empty space left
    func findNextEmpty() -> Int{
        var place = 0
        var found = false
        while !found {
            if let squareTitle = solvingSquares[place].text {
                if squareTitle == squarePlaceholder {
                    found = true
                }
                else {
                    place += 1
                    if place >= 6 {
                        place = -1
                        found = true
                    }
                }
            }
        }
        return place
    }
    
    @IBAction func jumbleButtonPressed(_ sender: UIButton) {
        j_jumbleButtonPressed += 1
        wipeSquares()
        shuffledWord = String(currentWord.shuffled())
        populateButtonData()
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        
        //if there is a round already in progress
        if jumbleButton.isEnabled {
            let alertController = UIAlertController(title: "End current round?", message: "Are you sure you want to start a new round? You will forfeit the current round.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Never mind", style: .cancel, handler: nil)
            let cancelAction = UIAlertAction(title: "I'm sure!", style: .default, handler: {action in
                j_forfeited += 1
                self.startnewGame()
            })
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
        else {
            startnewGame()
        }
    }
    
    func startnewGame() {
        wipeSquares()
        //make sure the new word isn't the same as the old word
        var newWord = wordbank.randomElement()!
        while (newWord == currentWord) {
            newWord = wordbank.randomElement()!
        }
        currentWord = newWord
        shuffledWord = String(currentWord.shuffled())
        populateButtonData()
        turnGameOnOrOff(state: true)
    }
    
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        wipeSquares()
        for button in letterButtons {
            button.isEnabled = true
        }
    }
    
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        var guessWord = ""
        for letter in solvingSquares {
            guessWord += letter.text!
        }
        
        var title = ""
        var message = ""
        var actionTitle = ""
        if guessWord == currentWord {
            j_wordsUnjumbled += 1
            title = "You won!"
            message = "Congrats! The word was: \(currentWord)"
            actionTitle = "Yay!"
            turnGameOnOrOff(state: false)
        }
        else {
            title = "Incorrect"
            message = "Sorry, that wasn't the right answer"
            actionTitle = "Try again!"
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func wipeSquares() {
        for square in solvingSquares {
            square.text = squarePlaceholder
        }
    }
    
    func populateButtonData() {
        
        for button in letterButtons {
            button.setTitle(String(shuffledWord.removeFirst()), for: .normal)
            button.isEnabled = true
        }
            //this was all trying to get it to animate the same when the button title is changed but it won't work so I'll come back to it at a later time (post-project due date)
            /*
            let nextLetter = String(shuffledWord.removeFirst())
            if letterButtons[x].currentTitle! == String(nextLetter) {
                letterButtons[x].setTitle(squarePlaceholder, for: .normal)
                letterButtons[x].setTitle(nextLetter, for: .normal)
            }
            else {
                letterButtons[x].setTitle(nextLetter, for: .normal)
            }
            */
    }
    
    //this doesn't end up getting used but I thought it's a useful function to have
    func resetGame() {
        for button in letterButtons {
            button.setTitle(squarePlaceholder, for: .normal)
        }
    }
    
    func turnGameOnOrOff(state: Bool) {
        jumbleButton.isEnabled = state
        resetButton.isEnabled = state
        enterButton.isEnabled = state
        if state {
            j_totalGamesPlayed += 1
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //makes buttons round
        for button in letterButtons {
            button.layer.cornerRadius = button.frame.height * 0.5
            button.layer.masksToBounds = true
            button.isEnabled = false
        }
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
