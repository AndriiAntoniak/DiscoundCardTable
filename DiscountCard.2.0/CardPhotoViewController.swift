//
//  CardPhotoViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/7/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class CardPhotoViewController: UIViewController {

     var selectCard : Card?
    
    var cardMan = CardManager()
   
    @IBOutlet weak var frontImage: UIImageView!
    
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var barcodeImage: UIImageView?
    
    
    func installPhoto(){
        frontImage.image = cardMan.loadImageFromPath(path: (selectCard?.frontImage)!)
        backImage.image = cardMan.loadImageFromPath(path: (selectCard?.backImage)!)
        if let _ = cardMan.loadImageFromPath(path: (selectCard?.barcode)!){
            barcodeImage?.image = cardMan.loadImageFromPath(path: (selectCard?.barcode)!)
        }else{
            print("nety")
        }
    }
    
    
    func rotate(_ image: inout UIImage?){
        if let originalImage = image {
            let rotateSize = CGSize(width: originalImage.size.height, height: originalImage.size.width)
            UIGraphicsBeginImageContextWithOptions(rotateSize, true, 2.0)
            if let context = UIGraphicsGetCurrentContext() {
                context.rotate(by: 90.0 * CGFloat(Double.pi) / 180.0)
                context.translateBy(x: 0, y: -originalImage.size.height)
                originalImage.draw(in: CGRect.init(x: 0, y: 0, width: originalImage.size.width, height: originalImage.size.height))
                image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
        }
    }
    
  

    
    //TODO: remake IT!!!

    @IBAction func backToCardTable(_ sender: Any) {
        performSegue(withIdentifier: "fromPhotoToTable", sender: nil)
    }
    
    @IBAction func editSelectedCard(_ sender: Any) {
        performSegue(withIdentifier: "fromPhotoToAddEdit", sender: selectCard)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromPhotoToAddEdit"{
            let addEdit = segue.destination as! AddEditTableViewController
            addEdit.editCard = sender as? Card
        }else if segue.identifier == "fromPhotoToTable"{
            _ = segue.destination as! ViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        installPhoto()
        rotate(&frontImage.image)
        rotate(&backImage.image)
      //  rotate(&barcodeImage?.image)
        
    }

  
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
