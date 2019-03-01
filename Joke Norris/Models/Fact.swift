//
//  Fact.swift
//  Joke Norris
//
//  Created by Developer on 10/02/2019.
//  Copyright © 2019 Farsen. All rights reserved.
//

import Foundation

class Fact: Decodable {
    var id: String = ""
    var fact: String = ""
    var date: String = ""
    var vote: String = ""
    var points: String = ""
    var rating: Double?
    var imageData: Data?
}
