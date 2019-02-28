//
//  Fact.swift
//  Joke Norris
//
//  Created by Developer on 10/02/2019.
//  Copyright © 2019 Farsen. All rights reserved.
//

import Foundation

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    var toDouble: Double {
        return NumberFormatter().number(from: self)?.doubleValue ?? 0
    }
}

struct Fact: Decodable {
    let id: String
    var fact: String
    let date: String
    let vote: String
    let points: String
    var rating: Double?
}


