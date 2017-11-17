//
//  TreeDTouchViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/14/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class TreeDTouchViewController: UIViewController{

    
    var barcode : UIImage?
    var descriptionCard : String?
    
    
    @IBOutlet weak var barcodeImageView: UIImageView?
    
    @IBOutlet weak var descriptionTextView: UITextView?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor(theme: theme)
        
        barcodeImageView?.image = barcode!
        descriptionTextView?.text = descriptionCard!
        
        barcodeImageView?.layer.cornerRadius = 20
        barcodeImageView?.clipsToBounds = true
        
        descriptionTextView?.layer.cornerRadius = 20
        descriptionTextView?.clipsToBounds = true
        
    }

    
    
    
    
    
    
    
    
    
   

}
