//
//  AddEdit ImagePicker Extension.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 12/7/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import Foundation
import UIKit

extension AddEditTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        if whatIsImage == "front" {
            frontImageOutlet.image = image
        }else{
            backImageOutlet.image = image
        }
        picker.dismiss(animated: true, completion: {() in
            if self.whatIsImage == "front" {
                self.performSegue(withIdentifier: "fromAddToCrop", sender: self.frontImageOutlet.image)
            }else {
                self.performSegue(withIdentifier: "fromAddToCrop", sender: self.backImageOutlet.image)
            }
        })
    }
}
