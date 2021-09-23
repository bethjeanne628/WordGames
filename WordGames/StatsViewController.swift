//
//  StatsViewController.swift
//  WordGames
//
//  Created by Beth Silverstein
//

import UIKit

//stats for the jumble game start with j, starts for hangman start with h
var j_totalGamesPlayed = 0
var j_wordsUnjumbled = 0
var j_forfeited = 0
var j_jumbleButtonPressed = 0
var h_totalGamesPlayed = 0
var h_gamesWon = 0
var h_menHung = 0
var h_gamesForfeited = 0
var h_numLettersGuessed = 0
var lizardSpins = 0
var lizardSpinFound = false

class StatsViewController: UIViewController {
    
    @IBOutlet weak var j_gamesPlayedLabel: UILabel!
    @IBOutlet weak var j_wordsUnjumbledLabel: UILabel!
    @IBOutlet weak var j_forfeitedLabel: UILabel!
    @IBOutlet weak var j_jumblePressedLabel: UILabel!
    @IBOutlet weak var h_gamesPlayedLabel: UILabel!
    @IBOutlet weak var h_menSavedLabel: UILabel!
    @IBOutlet weak var h_menHungLabel: UILabel!
    @IBOutlet weak var h_forfeitedLabel: UILabel!
    @IBOutlet weak var h_lettersGuessedLabel: UILabel!
    @IBOutlet weak var lizardTitleLabel: UILabel!
    @IBOutlet weak var spinsLabel: UILabel!
    @IBOutlet weak var numSpinsLabel: UILabel!
    
    func firstLizardSpin() {
        let alertController = UIAlertController(title: "Congrats!", message: "You found the secret lizard spin! Make sure he doesn't get dizzy :)\n(Single tap to spin, double tap to reset)", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay, I'll try!", style: .default, handler: nil)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        j_gamesPlayedLabel.text = "\(j_totalGamesPlayed)"
        j_wordsUnjumbledLabel.text = "\(j_wordsUnjumbled)"
        j_forfeitedLabel.text = "\(j_forfeited)"
        j_jumblePressedLabel.text = "\(j_jumbleButtonPressed)"
        h_gamesPlayedLabel.text = "\(h_totalGamesPlayed)"
        h_menSavedLabel.text = "\(h_gamesWon)"
        h_menHungLabel.text = "\(h_menHung)"
        h_forfeitedLabel.text = "\(h_gamesForfeited)"
        h_lettersGuessedLabel.text = "\(h_numLettersGuessed)"
        numSpinsLabel.text = "\(lizardSpins)"
        if lizardSpins > 0 {
            lizardTitleLabel.isHidden = false
            spinsLabel.isHidden = false
            numSpinsLabel.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if lizardSpinFound {
            lizardSpinFound = false
            firstLizardSpin()
        }
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
