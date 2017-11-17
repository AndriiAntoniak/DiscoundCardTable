//
//  ThemePopOverViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/14/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class ThemePopOverViewController: UIViewController {

    var delegate :ChangeThemeDelegate?
    
    @IBAction func light(_ sender: UIButton) {
        delegate?.installTheme(newTheme: .light)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dark(_ sender: UIButton) {
        delegate?.installTheme(newTheme: .dark)
        self.dismiss(animated: true, completion: nil)
    }
    
}
