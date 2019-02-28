//
//  TableViewCell.swift
//  Joke Norris
//
//  Created by Developer on 28/02/2019.
//  Copyright © 2019 Farsen. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var fact: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rating: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
