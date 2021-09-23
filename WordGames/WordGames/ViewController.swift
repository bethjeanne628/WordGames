//
//  ViewController.swift
//  WordGames
//
//  Created by Beth Silverstein
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lizardImage: UIImageView!
    
    @IBAction func unwindToHomeScreen(_ segue: UIStoryboardSegue) {
        //this function is as empty as the abyss
        //or is it???
        lizardImage.transform = .identity //this resets the lizard if it has been spun
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

