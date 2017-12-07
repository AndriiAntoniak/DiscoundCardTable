//
//  Card Table SearchResultsUpdating Extension.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 12/7/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import Foundation
import UIKit

extension CardTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text! == "" {
            discountCard = cardManager.returnCard()
            filterCardByColor()
            tableView.reloadData()
        }else{
            searchCardByTitle(text: searchController.searchBar.text!)
        }
    }
    
    func searchCardByTitle(text: String) {
        discountCard = filterCard.filter( { (this)-> Bool in
            return (this.title?.lowercased().contains(text.lowercased()))!
        })
        tableView.reloadData()
    }
}
