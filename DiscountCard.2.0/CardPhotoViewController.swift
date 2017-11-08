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
    
   
    

    @IBAction func backToCardTable(_ sender: Any) {
        performSegue(withIdentifier: "fromPhotoToTable", sender: nil)
    }
    
    @IBAction func editSelectedCard(_ sender: Any) {
        performSegue(withIdentifier: "fromPhotoToAddEdit", sender: selectCard)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromPhotoToAddEdit"{
            print("edit2")
            let addEdit = segue.destination as! AddEditTableViewController
            addEdit.editCard = sender as? Card
        }else if segue.identifier == "fromPhotoToTable"{
            print("back2")
            _ = segue.destination as! ViewController
        }else{
            print("what?")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

}
