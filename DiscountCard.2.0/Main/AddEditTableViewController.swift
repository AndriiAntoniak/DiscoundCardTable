//
//  AddEditTableViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 10/31/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit
import RSBarcodes_Swift
import AVFoundation

class AddEditTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate,ScannerResultDelegate, CropImageDelegate{
    
    @IBOutlet weak var redColorFilter: UIButton!
    
    @IBOutlet weak var orangeColorFilter: UIButton!
    
    @IBOutlet weak var yellowColorFilter: UIButton!
    
    @IBOutlet weak var greenColorFilter: UIButton!
    
    @IBOutlet weak var blueColorFilter: UIButton!
    
    @IBOutlet weak var violetColorFilter: UIButton!
    
    @IBOutlet weak var frontImageOutlet: UIImageView!
    
    @IBOutlet weak var backImageOutlet: UIImageView!
    
    @IBOutlet weak var titleFiled: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var barcodeImage: UIImageView!
    
    @IBOutlet weak var barcodeString: UIButton!
    
    public var filterColorDictionary :[UIButton:String] = [:]
    
    var userDidChooseAnyColorFilter = false
    
    public var whatIsImage : String?
    
    private var cardMan = CardManager()
    
    var editCard : Card?
    
    var addCard : Card?
    
    var boolEditValue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleFiled.delegate = self
        self.descriptionTextView.delegate = self
        fillDictionary()
        if editCard != nil {
            userDidChooseAnyColorFilter = true
            boolEditValue = true
            insertCartValueWhichMustEditing()
        }
    }
    
    @IBAction func addFrontImage(_ sender: UIButton) {
        whatIsImage = "front"
        if frontImageOutlet.image != nil{
            frontImageOutlet.backgroundColor = UIColor.white
            frontImageOutlet.alpha = 1.0
        }
        executeAddingImage()
    }
    
    @IBAction func addBackImage(_ sender: UIButton) {
        whatIsImage = "back"
        if backImageOutlet.image != nil {
            backImageOutlet.backgroundColor = UIColor.white
            backImageOutlet.alpha = 1.0
        }
        executeAddingImage()
    }
    
    //func for image picker controller
    func executeAddingImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        let addImage = UIAlertController(title: "Photo Source", message: "Choose a source of photo", preferredStyle: UIAlertControllerStyle.actionSheet)
        addImage.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(_:UIAlertAction) in
            if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                let closeAlertAction = UIAlertController(title: "Error", message: "Camera is not available", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                closeAlertAction.addAction(alertAction)
                self.present(closeAlertAction, animated: true, completion: nil)
            }
        }))
        addImage.addAction(UIAlertAction(title: "Photo library", style: .default, handler: {(_:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        addImage.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(addImage, animated: true, completion: nil)
    }
    
    //delegate for barcode
    func returnStringBarcode(barcode str: String) {
        self.barcodeString.setTitle(str , for: .normal)
        self.barcodeImage.image = RSUnifiedCodeGenerator.shared.generateCode(self.barcodeString.currentTitle!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue)
    }
    
    //Action for button called _Create Barcode_
    @IBAction func buttonForCreatingBarcode(_ sender: UIButton) {
        let addBarcode = UIAlertController(title: "Creating barcode", message: "Choose a way for creating barcode", preferredStyle: UIAlertControllerStyle.actionSheet)
        addBarcode.addAction(UIAlertAction(title: "Generate", style: .default, handler: {(_:UIAlertAction) in
            let textFieldAlertController = UIAlertController(title: "Generate", message: "Please,enter barcode", preferredStyle: .alert)
            textFieldAlertController.addTextField{ (textField) in textField.text = "" }
            textFieldAlertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert:UIAlertAction) in
                let textField = textFieldAlertController.textFields![0]
                self.barcodeString.setTitle(textField.text , for: .normal)
                self.barcodeImage.image = RSUnifiedCodeGenerator.shared.generateCode(self.barcodeString.currentTitle!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue)
            }))
            let alertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            textFieldAlertController.addAction(alertAction)
            self.present(textFieldAlertController, animated: true, completion: nil)
        }))
        addBarcode.addAction(UIAlertAction(title: "Scan", style: .default, handler: {(action:UIAlertAction) in
            if TARGET_OS_SIMULATOR == 0 {
                self.performSegue(withIdentifier: "fromAddToScanner", sender: nil)
            } else {
                let closeAlertAction = UIAlertController(title: "Error", message: "Camera is not available", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                closeAlertAction.addAction(alertAction)
                self.present(closeAlertAction, animated: true, completion: nil)
            }
        }))
        addBarcode.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(addBarcode, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifaer = segue.identifier
        if identifaer == "fromAddToScanner" {
            let scann = segue.destination as? ScannerViewController
            scann?.delegate = self
        }else if identifaer == "fromAddToCrop" {
            let crop = segue.destination as? CropImageViewController
            crop?.image = sender as? UIImage
            let destination=segue.destination as? CropImageViewController
            destination?.delegate = self
        }
    }
    
    //MARK: Choosing color filter, only one is possible !!!
    
    @IBAction func choosingColorFilter(_ sender: UIButton) {
        if userDidChooseAnyColorFilter == false {
            for filter in filterColorDictionary {
                filter.key.backgroundColor = UIColor.white
                filter.key.alpha = 1.0
            }
            userDidChooseAnyColorFilter = true
        }
        if sender.backgroundColor == UIColor.white {
            for filter in filterColorDictionary {
                filter.key.backgroundColor = UIColor.white
                filter.key.alpha = 1.0
            }
            sender.backgroundColor = sender.borderColor
        }else {
            sender.backgroundColor = UIColor.white
        }
    }
    
    func lightUpGaps() {
        if frontImageOutlet.image == nil {
            frontImageOutlet.backgroundColor = UIColor.red
            frontImageOutlet.alpha = 0.7
        }
        if backImageOutlet.image == nil {
            backImageOutlet.backgroundColor = UIColor.red
            backImageOutlet.alpha = 0.7
        }
        if titleFiled == nil || titleFiled.text == "" {
            titleFiled.backgroundColor = UIColor.red
            titleFiled.alpha = 0.7
        }
        if !userDidChooseAnyColorFilter {
            for filter in filterColorDictionary {
                filter.key.backgroundColor = UIColor.red
                filter.key.alpha = 0.7
            }
        }
    }
    
    // exchange backgroundcolor
    @IBAction func textFieldDidEdit(_ sender: UITextField) {
        titleFiled.backgroundColor = UIColor.white
        titleFiled.alpha = 1.0
    }
    
    //MARK: Save changes
    
    @IBAction func saveCardButton(_ sender: UIButton) {
        
        if frontImageOutlet.image != nil && backImageOutlet.image != nil && titleFiled.text != "" && userDidChooseAnyColorFilter {
            
            if boolEditValue {
                editExistCard()
            } else{
                addNewCard()
            }
            performSegue(withIdentifier: "EditToCardTable", sender: nil)
        }else{
            let closeAlertAction = UIAlertController(title: "Error", message: "Please fill all required (red) fields or choose any color filter in the bottom", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            closeAlertAction.addAction(alertAction)
            self.present(closeAlertAction, animated: true, completion: nil)
            lightUpGaps()
        }
    }
    
    func fillDictionary() {
        filterColorDictionary[redColorFilter] = "Red"
        filterColorDictionary[orangeColorFilter] = "Orange"
        filterColorDictionary[yellowColorFilter] = "Yellow"
        filterColorDictionary[greenColorFilter] = "Green"
        filterColorDictionary[blueColorFilter] = "Blue"
        filterColorDictionary[violetColorFilter] = "Violet"
    }
    
    //MARK: Hide keyboard for textField and textView
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func insertCartValueWhichMustEditing() {
        if editCard?.barcode != nil {
            barcodeString.setTitle(editCard?.barcode, for: .normal)
            if let _ = barcodeString.currentTitle {
                barcodeImage.image = RSUnifiedCodeGenerator.shared.generateCode(barcodeString.currentTitle!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue)
            }
        }
        titleFiled.text = editCard?.title
        for filter in filterColorDictionary {
            if filter.value == editCard?.filterColor {
                filter.key.backgroundColor = filter.key.borderColor
                break
            }
        }
        if let _ = editCard?.frontImage {
            frontImageOutlet.image = cardMan.loadImageFromPath(path: (editCard?.frontImage)!)
        }
        if let _ = editCard?.backImage {
            backImageOutlet.image = cardMan.loadImageFromPath(path: (editCard?.backImage)!)
        }
        descriptionTextView.text = editCard?.descriptionCard ?? nil
    }
    
    func editExistCard() {
        userDidChooseAnyColorFilter = true
        editCard?.barcode = barcodeString.currentTitle
        editCard?.title = titleFiled.text
        fillDictionary()
        for filter in filterColorDictionary {
            if filter.key.backgroundColor != UIColor.white {
                editCard?.filterColor = filter.value
                break
            }
        }
        editCard?.frontImage = cardMan.addToUrl(frontImageOutlet.image!)
        editCard?.backImage = cardMan.addToUrl(backImageOutlet.image!)
        editCard?.descriptionCard = descriptionTextView.text
    }
    
    func addNewCard() {
        addCard = Card()
        addCard?.date = Date()
        addCard?.title = titleFiled.text
        for filter in filterColorDictionary {
            if filter.key.backgroundColor != UIColor.white {
                addCard?.filterColor = filter.value
                break
            }
        }
        addCard?.frontImage = cardMan.addToUrl(frontImageOutlet.image!)
        addCard?.backImage = cardMan.addToUrl(backImageOutlet.image!)
        
        if barcodeString.currentTitle != "Create Barcode" {
            addCard?.barcode = barcodeString.currentTitle
        }
        
        addCard?.descriptionCard = descriptionTextView.text
    }
    
    func croppingImage(_ image: UIImage) {
        if whatIsImage == "front" {
            frontImageOutlet.image = image
        }else{
            backImageOutlet.image = image
        }
    }
}
