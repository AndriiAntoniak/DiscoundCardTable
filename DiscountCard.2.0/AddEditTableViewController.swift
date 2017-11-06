//
//  AddEditTableViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 10/31/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class AddEditTableViewController: UITableViewController, UIImagePickerControllerDelegate ,
UINavigationControllerDelegate{
    
    
    private var cardMan = CardManager()
    var editCard : Card?
    var addCard : Card?
    private var whatIsImage : String?
    
    @IBOutlet weak var frontImageOutlet: UIImageView!
    
    @IBOutlet weak var backImageOutlet: UIImageView!
    
    
    
   
    @IBOutlet weak var titleFiled: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var barcodeImage: UIImageView!
    

    
    //func for adding front image
    @IBAction func addFrontImage(_ sender: UIButton) {
        whatIsImage = "front"
        executeAddingImage()
    }
    
    //func for adding back image
    @IBAction func addBackImage(_ sender: UIButton) {
        whatIsImage = "back"
        executeAddingImage()
    }
    
    //func for image picker controller
    func executeAddingImage(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let addImage = UIAlertController(title: "Photo Source", message: "Choose a source of photo", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        addImage.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            if(UIImagePickerController.isSourceTypeAvailable(.camera)){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                let closeAlertAction = UIAlertController(title: "Error", message: "Camera is not available", preferredStyle: .actionSheet)
                let alertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                closeAlertAction.addAction(alertAction)
                self.present(closeAlertAction, animated: true, completion: nil)
            }
        }))
        
        addImage.addAction(UIAlertAction(title: "Photo library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        addImage.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(addImage, animated: true, completion: nil)
    }
    
    
    // outlet for button called _Create Barcode_
    @IBOutlet weak var barcodeString: UIButton!
    
    //Action for button called _Create Button_
    @IBAction func buttonForCreatingBarcode(_ sender: UIButton) {
        barcodeString.setTitle("2060040899772", for: .normal)
        //
        barcodeImage.image = executeGeneratingBarcode(from: barcodeString.currentTitle!)
    }
    
    
    //TODO: Here must be my barcode with some alert 
    func executeGeneratingBarcode(from string: String)-> UIImage?{
        
        let data = string.data(using: String.Encoding.ascii)
            
            if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
                filter.setValue(data, forKey: "inputMessage")
                let transform = CGAffineTransform(scaleX: 3, y: 3)
                
                if let output = filter.outputImage?.transformed(by: transform) {
                    return UIImage(ciImage: output)
                }
            }
            
            return nil
        
    }
    
    
    
    //MARK: Choosing color filter, only one is possible !!!
    
    @IBOutlet weak var redColorFilter: UIButton!
    
    @IBOutlet weak var orangeColorFilter: UIButton!
    
    @IBOutlet weak var yellowColorFilter: UIButton!
    
    @IBOutlet weak var greenColorFilter: UIButton!
    
    @IBOutlet weak var blueColorFilter: UIButton!
    
    @IBOutlet weak var violetColorFilter: UIButton!
    
    public var filterColorDictionary :[UIButton:String] = [:]
    
    @IBAction func choosingColorFilter(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white{
            for filter in filterColorDictionary{
                filter.key.backgroundColor = UIColor.white
            }
            sender.backgroundColor = sender.borderColor
            //
        }else{
            sender.backgroundColor = UIColor.white
        }
        
    }
    
    
    // MARK: Image picker controller delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        if whatIsImage == "front"{
            frontImageOutlet.image = image
        }else{
            backImageOutlet.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func SaveCardButton(_ sender: UIButton) {
        if boolEditValue{
            
            
            
            
            editCard?.title = titleFiled.text
            
            //Date is created in add
        //    editCard?.date = Date()
            
            fillDictionary()
            for filter in filterColorDictionary{
                if filter.key.backgroundColor != UIColor.white{
                    editCard?.filterColor = filter.value
                    break
                }
            }
            //TODO: MUST BE ALL PROPERTIES
        }else{
            addNewCard()
            //TODO: MUST BE ALL PROPERTIES
        }
        performSegue(withIdentifier: "EditToCardTable", sender: nil)
    }
    
    
    func fillDictionary(){
        filterColorDictionary[redColorFilter] = "Red"
        filterColorDictionary[orangeColorFilter] = "Orange"
        filterColorDictionary[yellowColorFilter] = "Yellow"
        filterColorDictionary[greenColorFilter] = "Green"
        filterColorDictionary[blueColorFilter] = "Blue"
        filterColorDictionary[violetColorFilter] = "Violet"
    }
    
    var boolEditValue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillDictionary()
        if editCard != nil{
            boolEditValue = true
            insertCartValueWhichMustEditing()
            
            for filter in filterColorDictionary{
                if filter.value == editCard?.filterColor{
                    filter.key.backgroundColor = filter.key.borderColor
                    break
                }
            }
        }
    }
    
    func insertCartValueWhichMustEditing(){
        if barcodeImage.image != nil{
            
           
            
        }
        //TODO: barcode generator but now it will be LOL
        //TODO: PHOTO PHOTO PHOTO
        //TODO: filter like string
        //TODO: ALL MUST BE TODO !!!
        
        
        titleFiled.text = editCard?.title
        
        //        for filter in filterColorDictionary{
        //            if filter.value == editCard?.filterColor{
        //                filter.key.backgroundColor = filter.key.borderColor
        //                break
        //            }
        //        }
    }
    
    func addNewCard(){
        addCard = Card()
        addCard?.date = Date()
        addCard?.title = titleFiled.text
        for filter in filterColorDictionary{
            if filter.key.backgroundColor != UIColor.white{
                addCard?.filterColor = filter.value
                break
            }
        }
        
        //TODO: HERE MUST BE ALL PROPERTIES
    }
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    
    
    
    
    
    
}




