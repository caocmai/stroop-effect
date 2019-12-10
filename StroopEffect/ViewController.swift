//
//  ViewController.swift
//  StroopEffect
//
//  Created by Cao Mai on 12/1/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let colorChoices = ["red", "blue", "yellow", "green", "orange"]
    let newColor = [UIColor.red, UIColor.blue, UIColor.yellow, UIColor.green, UIColor.orange]
    
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
    
    func pushViewController() {
        // Creates a viewcontroller from a storyboard file
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GameOverViewController")
        // Push view controller!
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func getRandom() {
        
        randomNumOne = Int.random(in: 0..<colorChoices.count)
        colorToMatch.text = colorChoices[randomNumOne]
        
        // Generate new list so there's a one in three chance of getting the proper color
        var newList: [Any] = []
        
        newList.append(newColor[randomNumOne])
        var i = 1
        while i > 0 {
            var tempRandom = Int.random(in: 0..<newColor.count)
            while tempRandom == randomNumOne {
                tempRandom = Int.random(in: 0..<newColor.count)
            }
            newList.append(newColor[tempRandom])
            i -= 1
        }
        
        randomNumTwo = Int.random(in: 0..<newList.count)
        
        var randomNum3 = Int.random(in: 0..<newColor.count)
         
        while randomNum3 == randomNumTwo {
            randomNum3 = Int.random(in: 0..<newColor.count)
         }
         
        wrongColorWord.text = colorChoices[randomNum3]
        wrongColorWord.textColor = newList[randomNumTwo] as? UIColor
        
//        self.view.backgroundColor = newList[randomNumTwo] as? UIColor

        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getRandom()
        score = 0
        scoreLabel.text = String(score)
        time = 30
        timeLabel.text = String(time)
        timely()
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        getRandom()
        score = 0
        scoreLabel.text = String(score)
        time = 30
        timeLabel.text = String(time)
        timely()
    }
    
//    @IBAction func unwindTo<#name#>(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
//        // Use data from the view controller which initiated the unwind segue
//    }
    
//    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
//        <#code#>
//    }

}

