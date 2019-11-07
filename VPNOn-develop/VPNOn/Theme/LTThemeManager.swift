//
//  LTThemeManager.swift
//  VPNOn
//
//  Created by Lex on 1/15/15.
//  Copyright (c) 2017 lexrus.com. All rights reserved.
//

import UIKit

let kCurrentThemeIndexKey = "CurrentThemeIndex"

class LTThemeManager {

    var currentTheme: LTTheme? = .none
    
    let themes: [LTTheme] = [LTDarkTheme(), LTLightTheme(), LTHelloKittyTheme(), LTDarkGreenTheme(), LTDarkPurpleTheme()]
    
    class var shared: LTThemeManager {
        struct Static
        {
            static let sharedInstance = LTThemeManager()
        }
        
        return Static.sharedInstance
    }
    
    var themeIndex: Int {
        get {
            if let index = UserDefaults.standard.object(forKey: kCurrentThemeIndexKey) as? NSNumber {
                if index.isKind(of: NSNumber.self) {
                    return min(themes.count - 1, index.intValue)
                }
            }
            return 0
        }
        set {
            let newNumber = NSNumber(value: newValue)
            UserDefaults.standard.set(newNumber, forKey: kCurrentThemeIndexKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    func activateTheme() {
        activateTheme(themes[themeIndex])
    }
    
    func activateTheme(_ theme : LTTheme) {
        currentTheme = theme
        
        UIWindow.appearance().tintColor = theme.tintColor
        LTViewControllerBackground.appearance().backgroundColor = theme.defaultBackgroundColor
        
        // Switch
        UISwitch.appearance().tintColor = theme.switchBorderColor
        UISwitch.appearance().onTintColor = theme.tintColor
        UISwitch.appearance().thumbTintColor = theme.switchBorderColor
        
        // Navigation
        UINavigationBar.appearance().barTintColor = theme.navigationBarColor
        UINavigationBar.appearance().tintColor = theme.tintColor
        UINavigationBar.appearance().backgroundColor = UIColor.clear
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: theme.textColor]
        
        // TableView
        UITableView.appearance().backgroundColor = theme.tableViewBackgroundColor
        UITableView.appearance().separatorColor = theme.tableViewLineColor
        UITableViewCell.appearance().backgroundColor = theme.tableViewCellColor
        UITableViewCell.appearance().tintColor = theme.tintColor
        UITableViewCell.appearance().selectionStyle = UITableViewCell.SelectionStyle.none
        UILabel.inside(UITableViewHeaderFooterView.self).textColor = theme.textColor
        LTTableViewCellTitle.appearance().textColor = theme.textColor
        UILabel.inside(LTTableViewActionCell.self).textColor = theme.tintColor
        UILabel.inside(VPNTableViewCell.self).textColor = theme.textColor
        UILabel.inside(NormalTableViewCell.self).textColor = theme.textColor
        UILabel.inside(AcknowledgementCell.self).textColor = theme.textColor
        UITextView.inside(UITableViewCell.self).backgroundColor = theme.tableViewCellColor
        UITextView.inside(UITableViewCell.self).textColor = theme.textColor
        
        // TextField
        UITextField.appearance().tintColor = theme.tintColor
        UITextField.appearance().textColor = theme.textFieldColor
        
    }
    
    func activateNextTheme() {
        var index = themeIndex
        index += 1
        
        if index >= themes.count {
            themeIndex = 0
        } else {
            themeIndex = index
        }
        
        activateTheme(themes[themeIndex])
        
        let windows = UIApplication.shared.windows
        
        for window in windows {
            for view in window.subviews {
                view.removeFromSuperview()
                window.addSubview(view )
            }
        }
    }
}
