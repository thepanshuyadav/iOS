//
//  CardDesignView.swift
//  SIH-Pothole
//
//  Created by Deepanshu Yadav on 22/01/20.
//  Copyright © 2020 Deepanshu Yadav. All rights reserved.
//

import UIKit

class CardDesignView: UIView {

    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 10.0)
        roundedRect.addClip()
        UIColor.systemTeal.setFill()
        roundedRect.fill()
    }

}
