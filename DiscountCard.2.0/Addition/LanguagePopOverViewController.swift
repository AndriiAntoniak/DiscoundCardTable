//
//  LanguagePopOverViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/15/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class LanguagePopOverViewController: UIViewController {
   
    var delegate : ChangeLanguageDelegate?
    
    var language : String!
    
    @IBAction func english(_ sender: UIButton) {
        language = "English"
         changeLanguage(use: "en")
    }
    
    @IBAction func ukrainian(_ sender: UIButton) {
        language = "Ukrainian"
        changeLanguage(use: "uk")
    }
    
    @IBAction func spanish(_ sender: UIButton) {
        language = "Spanish"
        changeLanguage(use: "es")
    }
    
    @IBAction func german(_ sender: UIButton) {
        language = "German"
        changeLanguage(use: "de")
    }
    
    @IBAction func polish(_ sender: UIButton) {
        language = "Polish"
        changeLanguage(use: "pl")
    }
    
    private func changeLanguage(use langCode: String){
        if Bundle.main.preferredLocalizations.first != langCode{
            
            let confirmAlertController = UIAlertController(title: /*NSLocalizedString("restartTitle", comment: "")*/"Your app must be closed for changing language", message: /*NSLocalizedString("restart", comment: "")*/"App restart required", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: NSLocalizedString("close", comment: ""), style: .destructive, handler: {_ in
                UserDefaults.standard.set([langCode], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                self.delegate?.installLanguage(newLanguage: self.language)
                exit(0)
            })
            
            confirmAlertController.addAction(confirmAction)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .default, handler: {_ in
                self.dismiss(animated: true, completion: nil)
            })
            
            confirmAlertController.addAction(cancelAction)
            
            present(confirmAlertController, animated: true, completion: nil)
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

  

}
