//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Deepanshu Yadav on 16/12/19.
//  Copyright © 2019 Deepanshu Yadav. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
    
    let themes = [
        "Sports":"⚽️🏀⚾️🏉🏸🏓🎱🏑🏏",
        "Animals":"🐶🐒🐰🐻🐼🐸🙀🐍🦄",
        "Fruits":"🍎🍊🍑🥭🍋🍌🥑🍓🥝"
    ]
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
        }
    }
    
}
