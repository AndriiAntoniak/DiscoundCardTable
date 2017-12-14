//
//  PopOverViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/10/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {
    
    var delegate : CardSortDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor(theme:theme)
    }
    
 
    
    @IBAction func sortBy(_ sender: UIButton) {
        switch sender.tag {
        case 1: delegate?.sortedCardList(by: SortAttribute.higherDate)
        case 2: delegate?.sortedCardList(by: SortAttribute.lowerDate)
        case 3: delegate?.sortedCardList(by: SortAttribute.higherTitle)
        case 4: delegate?.sortedCardList(by: SortAttribute.lowerTitle)
        default: break
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func fromHigherToLowerByDate(_ sender: UIButton) {
        delegate?.sortedCardList(by: SortAttribute.higherDate)
        
    }
    
    @IBAction func fromLowerToHigherByDate(_ sender: UIButton) {
        delegate?.sortedCardList(by: SortAttribute.lowerDate)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fromHigherToLowerByTitle(_ sender: UIButton) {
        delegate?.sortedCardList(by: SortAttribute.higherTitle)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fromLowerToHigherByTitle(_ sender: UIButton) {
        delegate?.sortedCardList(by: SortAttribute.lowerTitle)
        dismiss(animated: true, completion: nil)
    }
}
