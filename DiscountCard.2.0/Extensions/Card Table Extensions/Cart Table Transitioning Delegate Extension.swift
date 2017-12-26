//
//  Cart Table Transitioning Delegate Extension.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 12/26/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import Foundation
import UIKit

extension CardTableViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FlipPresentAnimationController(originFrame: rectungle)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let revealVC = dismissed as? CardPhotoViewController else {
            return nil
        }
        return FlipDismissAnimationController(destinationFrame: rectungle, interactionController: revealVC)
    }
}
