//
//  Petition.swift
//  Petitions
//
//  Created by Deepanshu Yadav on 15/01/20.
//  Copyright © 2020 Deepanshu Yadav. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
