//
//  CropImageViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/9/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class CropImageViewController: UIViewController, UIScrollViewDelegate{


    var newImage : UIImage?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageView = UIImageView()
    
    var image : UIImage?
    
    var delegate : CropImageDelegate?
    
    @IBAction func cropButton(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(scrollView.bounds.size, true, UIScreen.main.scale)
        
        let offSet = scrollView.contentOffset
      

        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: -offSet.x, y: -offSet.y)
        scrollView.layer.render(in: UIGraphicsGetCurrentContext()!)
         newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //
         delegate?.croppingImage(newImage!)
        dismiss(animated: true, completion: nil)
    }
    
    
   
    
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        
       
        imageView.frame = CGRect(x: 0, y: 0, width: (scrollView?.frame.size.width)!, height: (scrollView?.frame.size.height)!)
        
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        
        scrollView.addSubview(imageView)
        imageView.image = image
        imageView.contentMode = UIViewContentMode.center
        imageView.frame = CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!)
        scrollView.contentSize = (image?.size)!
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        
        let minScale = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1
        scrollView.zoomScale = minScale
         centerScrollViewContents()
        
        
        centerScrollViewContents()
 
   
    }
    
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    

    
    
    func centerScrollViewContents(){
        let boundsSize = scrollView.bounds.size
        var contentsFrame = imageView.frame
        
        if contentsFrame.size.width < boundsSize.width{
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2
        }else{
            contentsFrame.origin.x = 0
        }
        
        if contentsFrame.size.height < boundsSize.height{
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2
        }else{
            contentsFrame.origin.y = 0
        }
        imageView.frame = contentsFrame
    }
    
    

    

}
