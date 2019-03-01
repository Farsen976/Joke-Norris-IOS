//
//  CollectionViewCell.swift
//  Joke Norris
//
//  Created by Developer on 28/02/2019.
//  Copyright © 2019 Farsen. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    var fact: Fact?
    
    func constructCell(fact: Fact) -> CollectionViewCell{
        self.fact = fact
        
        let imageUrl:URL = URL(string: fact.fact)!
        
        if(fact.imageData != nil) {
            self.img.image = UIImage(data: fact.imageData!)
        } else {
            DispatchQueue.global().async {
                let imageData = NSData(contentsOf: imageUrl)
                if(imageData != nil){
                    self.fact!.imageData = imageData! as Data
                    DispatchQueue.main.async {
                        self.img.image = UIImage(data: self.fact!.imageData!)
                    }
                }
            }
        }
        
        return self
    }
}
