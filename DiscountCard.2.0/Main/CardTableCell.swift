//
//  CardTableCell.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 10/31/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class CardTableCell: UITableViewCell {
    
    @IBOutlet weak var frontImage: UIImageView!
    
    @IBOutlet weak var colorFilter: UILabel!
    
    @IBOutlet weak var cardTitle: UILabel!
    
    @IBOutlet weak var cardDate: UILabel!
    
    var cardDescription : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
