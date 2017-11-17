//
//  CardPhotoViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/7/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit
import RSBarcodes_Swift
import AVFoundation

class CardPhotoViewController: UIViewController , UIScrollViewDelegate {

     var selectCard : Card?
    
    var cardMan = CardManager()
   
    @IBOutlet weak var frontImage: UIImageView!
    
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var barcodeImage: UIImageView?
    
   var barcodeIsNil = false
    
    func installPhoto(){
        frontImage.image = cardMan.loadImageFromPath(path: (selectCard?.frontImage)!)
        backImage.image = cardMan.loadImageFromPath(path: (selectCard?.backImage)!)
        
        if let _ = RSUnifiedCodeGenerator.shared.generateCode((selectCard?.barcode)!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue){
            barcodeImage?.image = RSUnifiedCodeGenerator.shared.generateCode((selectCard?.barcode)!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue)
        }else{
            barcodeImage?.image = #imageLiteral(resourceName: "Flag_of_None")
            barcodeIsNil = true
        }

    }
    

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
            _ = segue.destination as! CardTableViewController
        }
    }
    
    func roundedCornerViewController(){
        frontImage?.layer.cornerRadius = 20
        frontImage?.clipsToBounds = true
        
        backImage?.layer.cornerRadius = 20
        backImage?.clipsToBounds = true
        
        barcodeImage?.layer.cornerRadius = 20
        barcodeImage?.clipsToBounds = true
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor(theme:theme)
        
        installPhoto()
        roundedCornerViewController()
       
       
        
        
        frontImage.image = RotateImage.rotateImage(image: frontImage.image)
        backImage.image = RotateImage.rotateImage(image: backImage.image)
        
        if !barcodeIsNil{
            barcodeImage?.image = RotateImage.rotateImage(image: barcodeImage?.image)
        }
        //
        scrollPhotoView.delegate = self
    }

    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var scrollPhotoView: UIScrollView!
    
  
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollPhotoView.contentOffset.x / scrollPhotoView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    

}
