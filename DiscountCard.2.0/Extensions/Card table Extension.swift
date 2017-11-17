//
//  Card table Extension.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/14/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//


import UIKit
import AVFoundation
import RSBarcodes_Swift

extension CardTableViewController: UIViewControllerPreviewingDelegate{
    
    
    //peek
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: location),
            let cell = tableView.cellForRow(at: indexPath) else {
                return nil
        }
        
        guard let TreeDVC = storyboard?.instantiateViewController(withIdentifier: "TreeDVC") as? TreeDTouchViewController else{
            return nil
        }
        
        
        if let _ = RSUnifiedCodeGenerator.shared.generateCode(discountCard[indexPath.row].barcode!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue){
            TreeDVC.barcode = RSUnifiedCodeGenerator.shared.generateCode(discountCard[indexPath.row].barcode!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue)
        }else{
            TreeDVC.barcode = #imageLiteral(resourceName: "Flag_of_None")
        }
        
        if let _ = discountCard[indexPath.row].descriptionCard{
            TreeDVC.descriptionCard = discountCard[indexPath.row].descriptionCard
        }else{
            TreeDVC.descriptionCard = ""
        }
        
        quickActionBarcode = TreeDVC.barcode
        quickActionDescription = TreeDVC.descriptionCard
        
        TreeDVC.preferredContentSize = CGSize(width: self.accessibilityFrame.width / 2.0, height: self.accessibilityFrame.height / 2.0)
        
       previewingContext.sourceRect = cell.frame
        return TreeDVC
        
        
    }
    
    
    //pop
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        if let treeDTouchPop = storyboard?.instantiateViewController(withIdentifier: "TreeDTouchPop") as? TreeDTouchPopViewController{
            treeDTouchPop.barcode = quickActionBarcode
            treeDTouchPop.descriptionCard = quickActionDescription
            show(treeDTouchPop, sender: self)
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
}
