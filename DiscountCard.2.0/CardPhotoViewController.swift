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
    
    
    func rotate(_ image: UIImage?)->UIImage?{
        if let originalImage = image {
            let rotateSize = CGSize(width: originalImage.size.height, height: originalImage.size.width)
            UIGraphicsBeginImageContextWithOptions(rotateSize, true, 2.0)
            if let context = UIGraphicsGetCurrentContext() {
                context.rotate(by: 90.0 * CGFloat(Double.pi) / 180.0)
                context.translateBy(x: 0, y: -originalImage.size.height)
                originalImage.draw(in: CGRect.init(x: 0, y: 0, width: originalImage.size.width, height: originalImage.size.height))
                let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return rotatedImage!
            }
        }
        return nil
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
            _ = segue.destination as! ViewController
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

        
        installPhoto()
        roundedCornerViewController()
       
        //
        frontImage.image = rotate(frontImage.image)
        backImage.image = rotate(backImage.image)
        
        if !barcodeIsNil{
            barcodeImage?.image = rotate(barcodeImage?.image)
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
