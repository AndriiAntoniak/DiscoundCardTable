//
//  SettingsViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/14/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPopoverPresentationControllerDelegate, ChangeThemeDelegate, ChangeLanguageDelegate{
    
    
    @IBOutlet weak var oldPassword: UITextField?
    
    @IBOutlet weak var newPassword: UITextField?
    
    @IBOutlet weak var repeatNewPassword: UITextField?
    
    
    @IBOutlet weak var oldImage: UIImageView?
    
    @IBOutlet weak var repeatImage: UIImageView?
    
    @IBOutlet weak var newImage: UIImageView!
    
    @IBAction func changePassword(_ sender: UIButton) {
        if oldPassword?.isEnabled == false{
            if newPassword?.text != "" && newPassword?.text == repeatNewPassword?.text{
                let defaults = UserDefaults.standard
                defaults.set(self.newPassword?.text,forKey: "currentPassword")
                repeatImage?.image = #imageLiteral(resourceName: "goodPassword")
                newImage.image = #imageLiteral(resourceName: "goodPassword")
                oldImage?.image = #imageLiteral(resourceName: "goodPassword")
            }else{
                if newPassword?.text == ""{
                    newImage.image = #imageLiteral(resourceName: "badPassword")
                }
                if newPassword?.text != repeatNewPassword?.text{
                    repeatImage?.image = #imageLiteral(resourceName: "badPassword")
                }
            }
        }else if oldPassword?.text == "" || oldPassword?.text != currentPassword {
            oldImage?.image = #imageLiteral(resourceName: "badPassword")
        }else if newPassword?.text != "" && newPassword?.text == repeatNewPassword?.text && currentPassword == oldPassword?.text {
            let defaults = UserDefaults.standard
            defaults.set(self.newPassword?.text,forKey: "currentPassword")
            //
            repeatImage?.image = #imageLiteral(resourceName: "goodPassword")
            newImage.image = #imageLiteral(resourceName: "goodPassword")
            oldImage?.image = #imageLiteral(resourceName: "goodPassword")
            //
        }else{
            if newPassword?.text == ""{
                newImage.image = #imageLiteral(resourceName: "badPassword")
            }else{
                newImage.image = #imageLiteral(resourceName: "goodPassword")
            }
            if newPassword?.text != repeatNewPassword?.text{
                repeatImage?.image = #imageLiteral(resourceName: "badPassword")
            }else{
                repeatImage?.image = #imageLiteral(resourceName: "goodPassword")
            }
            if currentPassword == oldPassword?.text{
                oldImage?.image = #imageLiteral(resourceName: "goodPassword")
            }else{
                oldImage?.image = #imageLiteral(resourceName: "badPassword")
            }
        }
    }
    
    
    
    
    

    @IBOutlet weak var themeButton: UIButton!
    
    @IBOutlet weak var languageButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentPassword == ""{
            oldPassword?.isEnabled = false
            oldPassword?.placeholder = "not exist"
        }
        
        
        imageView.layer.cornerRadius = 30
        
        view.backgroundColor(theme: theme)
        
        switch theme {
        case .light:
            themeButton.setBackgroundImage(#imageLiteral(resourceName: "OrangeGradient"), for: .normal)
        case .dark:
            themeButton.setBackgroundImage(#imageLiteral(resourceName: "blueGradient"), for: .normal)
        }
        
        
        let defaults = UserDefaults.standard
        let language = defaults.object(forKey: "currentLanguage") as! String?
        
        
        if let newLanguage = language{
            switch newLanguage{
            case "English": languageButton.setBackgroundImage(#imageLiteral(resourceName: "English"), for: .normal)
            case "Ukrainian": languageButton.setBackgroundImage(#imageLiteral(resourceName: "Ukrainian"), for: .normal)
            case "Spanish": languageButton.setBackgroundImage(#imageLiteral(resourceName: "Spanish"), for: .normal)
            case "German": languageButton.setBackgroundImage(#imageLiteral(resourceName: "German"), for: .normal)
            case "Polish": languageButton.setBackgroundImage(#imageLiteral(resourceName: "Polish"), for: .normal)
            default:break
            }
        }else{
            languageButton.setBackgroundImage(#imageLiteral(resourceName: "English"), for: .normal)
        }
    }
    
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "fromSettingsToCardTable", sender: nil)
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSettingsToTheme"{
            let popTheme = segue.destination as? ThemePopOverViewController
            popTheme?.preferredContentSize = CGSize(width: view.frame.width / 2.5, height: view.frame.height / 4.5)
            popTheme?.popoverPresentationController?.delegate = self
            popTheme?.delegate = self
        }else if segue.identifier == "fromSettingsToLanguage"{
            let popLanguage = segue.destination as? LanguagePopOverViewController
            popLanguage?.preferredContentSize = CGSize(width: view.frame.width / 2.5, height: view.frame.height / 4.5)
            popLanguage?.popoverPresentationController?.delegate = self
            popLanguage?.delegate = self
        }
    }
    
    
    func installTheme(newTheme: Theme) {
        let defaults = UserDefaults.standard
        theme = newTheme
        view.backgroundColor(theme: theme, fromPop: true)
        switch newTheme {
        case .light:
            themeButton.setBackgroundImage(#imageLiteral(resourceName: "OrangeGradient"), for: .normal)
            defaults.set("light",forKey: "currentTheme")
        case .dark:
            themeButton.setBackgroundImage(#imageLiteral(resourceName: "blueGradient"), for: .normal)
            defaults.set("dark",forKey: "currentTheme")
        }
    }
    
    func installLanguage(newLanguage: String) {
       
        
        let defaults = UserDefaults.standard
        defaults.set(newLanguage,forKey: "currentLanguage")
        
        
        
    }
    
    
    
    
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
    
    
  

}
