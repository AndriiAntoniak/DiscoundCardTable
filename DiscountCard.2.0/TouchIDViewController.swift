//
//  TouchIDViewController.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/10/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIDViewController: UIViewController {

    let passwordLOL = "12345"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        touchID()
       
        
    }
    
   
    
    func touchID(){
        
        let context = LAContext()
        
         var error : NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            self.view.backgroundColor = UIColor.green
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Because we need!", reply: {(issuccessfull,error) in
                if issuccessfull{
                    self.goToTable()
                }else{
                    if let error = error as NSError?{
                        
                        switch error.code {
                        case LAError.userCancel.rawValue:
                            exit(0)
                        case LAError.userFallback.rawValue:
                            print("user wonna enter password")
                           
                            self.enterPassword()
                        //    self.badTouchID()
                        default: break
                        }
                    }
                    self.enterPassword()
                }
            })
        }else{
            enterPassword()
        }
    }

    func goToTable(){
        let alert = UIAlertController(title: "DONE", message: nil, preferredStyle: .alert)
        self.present(alert, animated: true, completion: {() in
            self.performSegue(withIdentifier: "fromTouchIDToTable", sender: nil)
        })
    }
    
    var password : UITextField?
    
    
    func enterPassword(){
        
        let passwordAlertController = UIAlertController(title: "Password", message: "Please,enter your password", preferredStyle: .alert)
  
        DispatchQueue.main.async {
        passwordAlertController.addTextField(configurationHandler: {(textField) in
            textField.isSecureTextEntry = true
            textField.text = ""
        })
       
        }
        
        passwordAlertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert:UIAlertAction) in
          
            let enteredPassword = passwordAlertController.textFields![0]
            if enteredPassword.text == self.passwordLOL{
                self.goToTable()
            }else{
                print("wrong Password")
                exit(0)
            }
        }))
        
        let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        passwordAlertController.addAction(alertAction)
        
        
      
        
        self.present(passwordAlertController, animated: true, completion: nil)
        
        //
        
        
        
        
    }

    
    
    
    func badTouchID(){
     
        let alertController = UIAlertController(title: "Unrecognized fingerprints", message: "Please repeat or input password", preferredStyle: .alert)
        
        let repeatAction = UIAlertAction(title: "Repeat", style: .default, handler: {(action:UIAlertAction) in self.touchID()})
        
        alertController.addAction(repeatAction)
        
        let passwordAction = UIAlertAction(title: "Input password", style: .default, handler: {(action:UIAlertAction) in
            let passwordController = UIAlertController(title: "Input password", message: nil, preferredStyle: .alert)
            passwordController.addTextField(configurationHandler: {(textField) in
                textField.isSecureTextEntry = true
                textField.text = ""
            })
            passwordController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert:UIAlertAction) in
                let textField = passwordController.textFields![0]
                self.password?.text = textField.text
                }))
            
            let alertAction = UIAlertAction(title: "Close", style: .cancel, handler: {(action :UIAlertAction) in exit(0)})
           
            passwordController.addAction(alertAction)
            
            self.present(passwordController, animated: true, completion: nil)
            
        })
        alertController.addAction(passwordAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    
}//end class
