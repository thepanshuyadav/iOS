//
//  LTTheme.swift
//  VPNOn
//
//  Created by Lex on 1/15/15.
//  Copyright (c) 2017 lexrus.com. All rights reserved.
//

import UIKit

public protocol LTTheme
{
    var name                     : String  { get set }
    var defaultBackgroundColor   : UIColor { get set }
    var navigationBarColor       : UIColor { get set }
    var tintColor                : UIColor { get set }
    var textColor                : UIColor { get set }
    var placeholderColor         : UIColor { get set }
    var textFieldColor           : UIColor { get set }
    var tableViewBackgroundColor : UIColor { get set }
    var tableViewLineColor       : UIColor { get set }
    var tableViewCellColor       : UIColor { get set }
    var switchBorderColor        : UIColor { get set }
}
