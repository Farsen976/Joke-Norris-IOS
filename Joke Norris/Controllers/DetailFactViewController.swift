//
//  DetailFactViewController.swift
//  Joke Norris
//
//  Created by Developer on 01/03/2019.
//  Copyright © 2019 Farsen. All rights reserved.
//

import UIKit

class DetailFactViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rating: CosmosView!
    
    var fact: Fact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if(self.fact != nil && self.fact?.imageData != nil){
            self.image.image = UIImage(data: self.fact!.imageData!)
            self.date.text = Date(timeIntervalSince1970: self.fact!.date.toDouble).relativeTime
            self.rating.rating = self.fact!.rating ?? 0
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
