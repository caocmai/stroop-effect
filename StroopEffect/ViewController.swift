//
//  ViewController.swift
//  StroopEffect
//
//  Created by Cao Mai on 12/1/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let colorTextChoices = ["red", "blue", "yellow", "green", "orange"]
    let colorUIChoices = [UIColor.red, UIColor.blue, UIColor.yellow, UIColor.green, UIColor.orange]
    
    var score: Int = 0
    var time: Int = 30
    
    var timer = Timer()
    
    var randomNumOne = 0
    var randomNumTwo = 0
    

    
    @IBAction func startTapped(_ sender: UIButton) {
//        sender.isHidden = true
        getRandom()
        score = 0
        scoreLabel.text = String(score)
        time = 30
        timeLabel.text = String(time)
        timely()
    }
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @objc func updateTimer() {
        time -= 1
        timeLabel.text = String(time)
    }
    
    func timely() {
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        // needs this to make timer reset at the right speed
        if !timer.isValid{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        }else {
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        }

    }
    
    @IBOutlet weak var colorToMatch: UILabel!
    @IBOutlet weak var wrongColorWord: UILabel!
        
    @IBAction func noTapped(_ sender: Any) {
//        randomNumber()
//        changeColorWord()
        
    
        
        // Changes button but doeesn't go back
//        if let button : UIButton = sender as? UIButton
//        {
//            button.isSelected = !button.isSelected
//
//            if (button.isSelected)
//            {
//                button.backgroundColor = UIColor.green
//            }
//            else
//            {
//                button.backgroundColor = UIColor.red
//            }
//        }
        
        // Because the correct color will always be at index 0
        if randomNumTwo == 0 {
            score -= 10
            scoreLabel.text = String(score)
        } else {
            score += 10
            scoreLabel.text = String(score)
        }

        getRandom()
        checkGameStatus()
        
               
    }
    
    
    @IBAction func yesTapped(_ sender: Any) {
        
        // Changes button but doeesn't go back
//        if let button : UIButton = sender as? UIButton
//        {
//            button.isSelected = !button.isSelected
//
//            if (button.isSelected)
//            {
//                button.backgroundColor = UIColor.green
//            }
//            else
//            {
//                button.backgroundColor = UIColor.red
//            }
//        }
        
        // Because the correct color will always be at index 0
        if randomNumTwo == 0 {
            score += 10
            scoreLabel.text = String(score)
        } else {
            score -= 10
            scoreLabel.text = String(score)
        }
        
        getRandom()
        checkGameStatus()
        
    }
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Checking game status
    func checkGameStatus() {
        if (score < 0 || time < 0) {
            print("gameOVer")
            pushViewController()
//            timer.invalidate()
            //Run the you lose page
//            moveToGameOverScreen()
        }
    }
    
    // This function to go to a differenet scene in storyboard, programmatically
    func pushViewController() {
        // Creates a viewcontroller from a storyboard file
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GameOverViewController")
        // Push view controller!
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func getRandom() {
        
        randomNumOne = Int.random(in: 0..<colorTextChoices.count)
        colorToMatch.text = colorTextChoices[randomNumOne]
        
        // Generate new list so there's a one in however many in the array will be the correct color
        var newList: [Any] = []
        
        // Adding the correct color to the new array, so it's at position 0
        newList.append(colorUIChoices[randomNumOne])
        
        // This is so you can have a 1 in 2 or 1 in 3 or 1 in whatever chance the correct color will appear; just change i
        var i = 1
        while i > 0 {
            var tempRandom = Int.random(in: 0..<colorUIChoices.count)
            while tempRandom == randomNumOne {
                tempRandom = Int.random(in: 0..<colorUIChoices.count)
            }
            newList.append(colorUIChoices[tempRandom])
            i -= 1
        }
        
        // This then gets a random index from the newly created list with the correct color at always being at index 0
        randomNumTwo = Int.random(in: 0..<newList.count)
        
        // Get a random index for UIcolorChoices
        let randomNum3 = Int.random(in: 0..<colorUIChoices.count)
         
        // Sets text choice of 2nd card to be something random
        wrongColorWord.text = colorTextChoices[randomNum3]
        // Random, set the color of 2nd card from the newly created list, not original colorUIChoices list
        wrongColorWord.textColor = newList[randomNumTwo] as? UIColor
        
        // This is easy mode so the screen background will change to the correct color
        self.view.backgroundColor = newList[randomNumTwo] as? UIColor

    }
    
    override func viewDidLoad() {
        // To start game right when viewcontroller is loaded
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getRandom()
        score = 0
        scoreLabel.text = String(score)
        time = 30
        timeLabel.text = String(time)
        timely()
    }
    
    // This is need to unwind to Viewcontroller when player selects play again, in game over screen, also when they get to the page the game starts immediately
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        getRandom()
        score = 0
        scoreLabel.text = String(score)
        time = 30
        timeLabel.text = String(time)
        timely()
    }

}

