//
//  ViewController.swift
//  Guess the Flag
//
//  Created by Deepanshu Yadav on 04/01/20.
//  Copyright © 2020 Deepanshu Yadav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var score = 0
    var correctAnswer = 0
    var numberOfQuestionsAsked = 0
    var countries = ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","uk","us","russia","spain"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBorderWidth(for: button1)
        addBorderWidth(for: button2)
        addBorderWidth(for: button3)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor(red: 0.5, green: 0.8, blue: 1.0, alpha: 1)
        askQuestion()
        
    }
    
    private func addBorderWidth(for button: UIButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = CGColor(srgbRed: 0.8, green: 0.5, blue: 1, alpha: 1)
    }
    
    private func askQuestion(action: UIAlertAction! = nil) {
        if numberOfQuestionsAsked == 10 {
            return
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        title = countries[correctAnswer].uppercased() + "   Score : \(score)"
        addImageBgToButton(button1, for: 0)
        addImageBgToButton(button2, for: 1)
        addImageBgToButton(button3, for: 2)
        
    }
    private func addImageBgToButton(_ button: UIButton,for index : Int) {
        button.setImage(UIImage(named: countries[index]), for: .normal)
    }

    @IBAction func flagTapped(_ sender: UIButton) {
        var title : String
        
        if sender.tag == correctAnswer {
            title = "Correct Answer"
            score += 1
        } else {
            title = "Wrong Answer"
            score -= 1
        }
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac,animated: true)
        
    }
    
    
}

