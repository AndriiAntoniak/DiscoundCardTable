//
//  View extension.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/14/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func backgroundColor(theme: Theme = .light, fromPop : Bool = false) {
        
        let gradientColor = CAGradientLayer()
        gradientColor.frame = self.frame
        switch theme {
        case .dark:
            gradientColor.colors = [UIColor(red: 8/255.5,green:201/255.5,blue:255/255.5,alpha:1.0).cgColor,UIColor.blue.cgColor, UIColor.black.cgColor]
        case .light:
            gradientColor.colors = [UIColor.yellow.cgColor,UIColor.orange.cgColor, UIColor(red: 124/255.5,green:14/255.5,blue:54/255.5,alpha:1.0).cgColor]
        }
        gradientColor.locations=[0.0,0.5,1.0]
        gradientColor.startPoint = CGPoint(x:0.0,y:1.0)
        gradientColor.endPoint=CGPoint(x: 1.0, y: 0.0)
        if fromPop{
            self.layer.sublayers?.remove(at: 0)
            self.layer.insertSublayer(gradientColor, at: 0)
        }else{
            self.layer.insertSublayer(gradientColor, at: 0)
        }
    }
}
