//
//  Fact.swift
//  Joke Norris
//
//  Created by Developer on 10/02/2019.
//  Copyright © 2019 Farsen. All rights reserved.
//

import Foundation

struct Fact: Decodable {
    let id: String
    var fact: String
    let date: String
    let vote: String
    let points: String
    var rating: Double?
    var imageData: Data?
}


