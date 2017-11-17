//
//  TreeDTouchPopViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/16/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class TreeDTouchPopViewController: UIViewController {

    
    @IBOutlet weak var barcodeImage: UIImageView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var barcode : UIImage?
    var descriptionCard : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor(theme: theme)
        
        
        if let _ = barcode{
            barcodeImage?.image = barcode
            barcodeImage?.image = RotateImage.rotateImage(image: barcodeImage?.image)
        }else{
            barcodeImage?.image = #imageLiteral(resourceName: "Flag_of_None")
        }
        if let _ = descriptionCard{
            descriptionTextView.text = descriptionCard!
            descriptionTextView.isEditable = false
        }else{
            descriptionTextView.text = ""
            descriptionTextView.isEditable = false
        }
        
        
        barcodeImage?.layer.cornerRadius = 20
        barcodeImage?.clipsToBounds = true
        
        descriptionTextView?.layer.cornerRadius = 20
        descriptionTextView?.clipsToBounds = true
        
        
    }

    

}
