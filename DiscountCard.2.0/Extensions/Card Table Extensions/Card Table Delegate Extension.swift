//
//  Card Table Delegate Extension.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 12/7/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import Foundation
import UIKit

extension CardTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rectungle = tableView.cellForRow(at: indexPath)?.frame
        performSegue(withIdentifier: "fromCellToPhoto", sender: discountCard[indexPath.row])
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: nil) { action, sourceView, completionHandler  in
            CardManager.deleteCard(card: self.discountCard[indexPath.row])
            self.discountCard.remove(at: indexPath.row)
            tableView.reloadData()
            completionHandler(true)
        }
        let share = UIContextualAction(style: .normal, title: nil) { action, sourceView, completionHandler  in
            let front = self.cardManager.loadImageFromPath(path: self.discountCard[indexPath.row].frontImage!) ?? #imageLiteral(resourceName: "Flag_of_None")
            let back = self.cardManager.loadImageFromPath(path: self.discountCard[indexPath.row].backImage!) ?? #imageLiteral(resourceName: "Flag_of_None")
            let title = self.discountCard[indexPath.row].title ?? ""
            let activityVC = UIActivityViewController(activityItems: [front,back,title], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
            completionHandler(true)
        }
        let edit = UIContextualAction(style: .normal, title: nil) { action, sourceView, completionHandler  in
            self.performSegue(withIdentifier: "EditToCard", sender: self.discountCard[indexPath.row])
            completionHandler(true)
        }
        edit.backgroundColor = installColorForFilter(card:discountCard[indexPath.row])
        delete.backgroundColor = installColorForFilter(card:discountCard[indexPath.row])
        share.backgroundColor = installColorForFilter(card:discountCard[indexPath.row])
        delete.image = #imageLiteral(resourceName: "delete")
        share.image = #imageLiteral(resourceName: "share")
        edit.image = #imageLiteral(resourceName: "edit")
        let config = UISwipeActionsConfiguration(actions: [edit,share,delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}
