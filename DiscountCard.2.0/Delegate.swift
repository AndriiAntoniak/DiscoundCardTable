//
//  Delegate.swift
//  DiscountCard.2.0
//
//  Created by Andrii Antoniak on 11/9/17.
//  Copyright © 2017 Andrii Antoniak. All rights reserved.
//

import Foundation

protocol ScannerResultDelegate{
    func returnStringBarcode(barcode str:String)
}
