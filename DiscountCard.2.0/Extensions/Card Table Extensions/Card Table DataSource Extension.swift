//
//  Card Table DataSource Extension.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 12/7/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import Foundation
import UIKit

extension CardTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return discountCard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = discountCard[indexPath.row]
        print(indexPath.row)
        let cell  = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? CardTableCell
        cell?.cardTitle?.text = card.title
        cell?.cardDate?.text = DateFormatter.localizedString(from: card.date! as Date , dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
        cell?.colorFilter?.backgroundColor = installColorForFilter(card:card)
        if let _ = card.descriptionCard{
            cell?.cardDescription = card.descriptionCard
        }else{
            cell?.cardDescription = ""
        }
        cell?.frontImage?.image = cardManager.loadImageFromPath(path: card.frontImage!)
        cell?.frontImage?.layer.cornerRadius = 20
        cell?.frontImage?.clipsToBounds = true
        return cell!
    }
}
